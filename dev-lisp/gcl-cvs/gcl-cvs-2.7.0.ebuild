# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl-cvs/gcl-cvs-2.7.0.ebuild,v 1.6 2007/07/02 15:04:13 peper Exp $

ECVS_AUTH="pserver"
ECVS_SERVER="cvs.savannah.gnu.org:/sources/gcl"
ECVS_MODULE="gcl"
ECVS_BRANCH="HEAD"
ECVS_USER="anonymous"

inherit cvs elisp-common flag-o-matic eutils alternatives

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="emacs readline debug X tk custreloc dlopen gprof doc"
RESTRICT="$RESTRICT strip"

DEPEND=">=app-text/texi2html-1.64
	emacs? ( virtual/emacs )
	X? ( || ( ( x11-libs/libXt x11-libs/libXext x11-libs/libXmu x11-libs/libXaw ) virtual/x11 ) )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	doc? ( virtual/tetex )
	tk? ( dev-lang/tk )
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	export SANDBOX_ON="0"
	WANT_AUTOCONF=2.5 autoconf || die

	sed -e "s/gcl-doc/${PF}/g" ${S}/info/makefile > ${T}/makefile
	mv ${T}/makefile ${S}/info/makefile

	local myconfig=""

	# Hardened gcc may automatically use PIE building, which does not
	# work for this package so far

	filter-flags "-fPIC"

	# -fomit-frame-pointer cannot be used with gprof

	if use gprof; then
		filter-flags "-fomit-frame-pointer"
	fi

#	# Unfortunately, we need to override any relocation choices below
#	# while upstream doesn't work with system BFD.	SuSE has the same
#	# problem apparently.

#	if false; then

	# Linking options are enumerated at
	# http://www.gnu.org/software/gcl/RELEASE-2.6.2.html

	local dlopen_config="
		--disable-custreloc
		--enable-dlopen
		--disable-dynsysbfd
		--disable-statsysbfd";

	local bfd_config="
		--disable-custreloc
		--disable-dlopen
		--enable-dynsysbfd
		--disable-statsysbfd";

	local custreloc_config="
		--enable-custreloc
		--disable-dlopen
		--disable-dynsysbfd
		--disable-statsysbfd";

	if use custreloc; then
		case "${ARCH}" in
			x86 | sparc)
				myconfig="${myconfig} ${custreloc_config}";;
			*)
				ewarn "--enable-custreloc is not supported on your architecture (${ARCH})."
				ewarn "Using --enable-dlopen instead."
				myconfig="${myconfig} ${dlopen_config}"

		esac
	elif use dlopen; then
		myconfig="${myconfig} ${dlopen_config}"
	else
		case "${ARCH}" in
			x86 | sparc | ppc | amd64 | s390)
				myconfig="${myconfig} ${bfd_config}";;
			*)
				ewarn "BFD is not supported on your architecture (${ARCH})."
				ewarn "Using --enable-dlopen instead."
				myconfig="${myconfig} ${dlopen_config}";;
		esac
	fi

#	else
#		myconfig="${myconfig}
#		--enable-locbfd
#		--disable-dynsysbfd
#		--disable-statsysbfd"
#	fi

	if use tk; then
		myconfig="${myconfig}
		--enable-tkconfig=/usr/lib
		--enable-tclconfig=/usr/lib"
	fi

	myconfig="
		${myconfig}
		--enable-dynsysgmp
		--enable-ansi
		`use_enable readline readline`
		`use_with X x`
		`use_enable debug debug`
		`use_enable gprof gprof`
		--enable-xdr=no
		--enable-infodir=/usr/share/info
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl"

	einfo "Configuring with the following: ${myconfig}"
	econf ${myconfig} || die
	make || die
}

src_install() {
	export SANDBOX_ON="0"
	make DESTDIR=${D} install || die
	mv ${D}/usr/lib/gcl-${PV} ${D}/usr/lib/gcl
	doinfo ${D}/usr/lib/gcl/info/*.info*
	rm -rf ${D}/usr/lib/gcl/info
	mv ${D}/default.el elisp/

	if use emacs; then
		mv elisp/add-default.el ${T}/50gcl-gentoo.el
		elisp-site-file-install ${T}/50gcl-gentoo.el
		elisp-install ${PN} elisp/*
		fperms 0644 /usr/share/emacs/site-lisp/gcl/*
	else
		rm -rf ${D}/usr/share/emacs
	fi

	exeinto /usr/bin

	if use tk; then
		newexe ${FILESDIR}/gcl gcl
		dosed "s,@TKVER@,/usr/lib/tk$(source /usr/lib/tkConfig.sh; echo $TK_VERSION),g" \
			/usr/bin/gcl
		dosed /usr/lib/gcl/gcl-tk/gcltksrv
	else
		newexe ${FILESDIR}/gcl.notcltk gcl
	fi

	dosed "s,@SYS@,/usr/lib/gcl/unixport,g" /usr/bin/gcl
	dosed "s,@DIR@,/usr/lib/gcl,g" /usr/bin/gcl

	dodoc readme* RELEASE* ChangeLog* doc/*
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${PF}

	find ${D}/usr/lib/gcl/ -type f \( -perm 640 -o -perm 750 \) \
		-exec chmod 0644 '{}' \;
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
