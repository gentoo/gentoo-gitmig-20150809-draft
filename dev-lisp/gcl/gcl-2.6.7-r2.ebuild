# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.6.7-r2.ebuild,v 1.2 2006/12/13 05:38:46 mkennedy Exp $

inherit elisp-common flag-o-matic autotools

DEB_PV=32

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/g/gcl/gcl_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/g/gcl/gcl_${PV}-${DEB_PV}.diff.gz
	ftp://ftp.gnu.org/pub/gnu/gcl/${PN}.info.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="emacs readline debug X tk doc ansi"

RDEPEND="emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	tk? ( dev-lang/tk )
	X? ( || ( ( x11-libs/libXt x11-libs/libXext x11-libs/libXmu x11-libs/libXaw ) virtual/x11 ) )
	virtual/tetex"				# pdflatex (see Bug # 157903)

DEPEND="$RDEPEND
	doc? ( virtual/tetex )
	>=app-text/texi2html-1.64
	>=sys-devel/autoconf-2.52"

src_unpack() {
	unpack ${A}
	epatch gcl_${PV}-${DEB_PV}.diff
	sed -ie "s/gcl-doc/${PF}/g" ${S}/info/makefile
}

src_compile() {
	export SANDBOX_ON=0
	local myconfig=""
	# Hardened gcc may automatically use PIE building, which does not
	# work for this package so far
	filter-flags "-fPIC"
	if use tk; then
		myconfig="${myconfig} --enable-tkconfig=/usr/lib --enable-tclconfig=/usr/lib"
	fi
	myconfig="${myconfig}
		--enable-locbfd
		--disable-dynsysbfd
		--disable-statsysbfd
		--enable-dynsysgmp
		`use_enable readline readline`
		`use_with X x`
		`use_enable debug debug`
		`use_enable ansi ansi`
		--enable-xdr=no
		--enable-infodir=/usr/share/info
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl"
	einfo "Configuring with the following:
${myconfig}"
	econf ${myconfig} || die
	make || die
	sed -e 's,@EXT@,,g' debian/in.gcl.1 >gcl.1
}

src_install() {
	export SANDBOX_ON=0
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/lib/${P}/info
	mv ${D}/default.el elisp/

	if use emacs; then
		mv elisp/add-default.el ${T}/50gcl-gentoo.el
		elisp-site-file-install ${T}/50gcl-gentoo.el
		elisp-install ${PN} elisp/*
		fperms 0644 /usr/share/emacs/site-lisp/gcl/*
	else
		rm -rf ${D}/usr/share/emacs
	fi

	dosed /usr/bin/gcl
	fperms 0755 /usr/bin/gcl

	# fix the GCL_TK_DIR=/var/tmp/portage/${P}/image//
	dosed /usr/lib/${P}/gcl-tk/gcltksrv
	fperms 0755 /usr/lib/${P}/gcl-tk/gcltksrv

	#repair gcl.exe symlink
	#rm ${D}/usr/bin/gcl.exe
	dosym ../lib/${P}/unixport/saved_gcl /usr/bin/gcl.exe

	dodoc readme* RELEASE* ChangeLog* doc/*

	for i in ${D}/usr/share/doc/gcl-{tk,si}; do
		mv $i ${D}/usr/share/doc/${PF}
	done

	doman gcl.1
	doinfo info/*.info*

	find ${D}/usr/lib/gcl-${PV}/ -type f \( -perm 640 -o -perm 750 \) -exec chmod 0644 '{}' \;
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
