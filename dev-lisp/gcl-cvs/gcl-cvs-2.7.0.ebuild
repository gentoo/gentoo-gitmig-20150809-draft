# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl-cvs/gcl-cvs-2.7.0.ebuild,v 1.1 2004/12/10 03:50:16 mkennedy Exp $

ECVS_AUTH="ext"
export CVS_RSH="ssh"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gcl"
ECVS_MODULE="gcl"
ECVS_BRANCH="HEAD"
ECVS_USER="anoncvs"
ECVS_CVS_OPTIONS="-dP"
ECVS_SSH_HOST_KEY="savannah.gnu.org,199.232.41.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="

inherit cvs elisp-common flag-o-matic eutils alternatives common-lisp-common

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="emacs readline debug X tcltk custreloc dlopen gprof doc"
SANDBOX_DISABLED="1"
RESTRICT="$RESTRICT nostrip"

DEPEND=">=app-text/texi2html-1.64
	emacs? ( virtual/emacs )
	X? ( virtual/x11 )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	doc? ( virtual/tetex )
	tcltk? ( dev-lang/tk )
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	dev-lisp/common-lisp-controller
	>=dev-lisp/cl-defsystem3-3.3i-r3
	>=dev-lisp/cl-asdf-1.84"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
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

	if use tcltk; then
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

	if use tcltk; then
		newexe ${FILESDIR}/gcl gcl
		dosed "s,@TKVER@,/usr/lib/tk$(source /usr/lib/tkConfig.sh; echo $TK_VERSION),g" \
			/usr/bin/gcl
		dosed /usr/lib/gcl/gcl-tk/gcltksrv
	else
		newexe ${FILESDIR}/gcl.notcltk gcl
	fi

	dosed "s,@SYS@,/usr/lib/gcl/unixport,g" /usr/bin/gcl
	dosed "s,@DIR@,/usr/lib/gcl,g" /usr/bin/gcl

	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/gcl.sh
	cp ${D}/usr/lib/gcl/unixport/saved_ansi_gcl \
		${D}/usr/lib/gcl/unixport/saved_ansi_gcl.dist

	dodoc readme* RELEASE* ChangeLog* doc/*
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${PF}

	find ${D}/usr/lib/gcl/ -type f \( -perm 640 -o -perm 750 \) \
		-exec chmod 0644 '{}' \;
}

pkg_postinst() {
	standard-impl-postinst gcl
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
