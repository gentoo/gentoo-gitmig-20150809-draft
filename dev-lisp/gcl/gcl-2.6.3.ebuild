# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.6.3.ebuild,v 1.1 2004/08/07 05:22:07 mkennedy Exp $

inherit elisp-common flag-o-matic

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI="ftp://ftp.gnu.org/gnu/gcl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="emacs readline debug X tcltk ansi"

DEPEND=">=app-text/texi2html-1.64
	emacs? ( virtual/emacs )
	X? ( virtual/x11 )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	virtual/tetex"

src_unpack() {
	unpack ${A}
	sed -e "s/gcl-doc/${PF}/g" ${S}/info/makefile > ${T}/makefile
	mv ${T}/makefile ${S}/info/makefile
}

src_compile() {
	local myconfig=""

	# hardened gcc may automatically use PIE building, which does not
	# work for this package so far
	filter-flags "-fPIC"

	# See http://www.gnu.org/software/gcl/RELEASE-2.6.2.html

	case ${ARCH} in
		x86 | sparc)
			myconfig="${myconfig}
				--enable-custreloc
				--disable-dlopen
				--disable-dynsysbfd
				--disable-statsysbfd";;
		*)
			myconfig="${myconfig}
				--disable-custreloc
				--disable-dlopen
				--enable-dynsysbfd
				--disable-statsysbfd";;
	esac

	myconfig="${myconfig}
		--enable-dynsysgmp
		`use_enable readline readline`
		`use_with X x`
		`use_enable debug debug`
		`use_enable tcltk tkconfig=/usr/lib`
		`use_enable tcltk tclconfig=/usr/lib`
		`use enable ansi ansi`
		--enable-xdr=no
		--enable-infodir=/usr/share/info
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl"
	einfo "Configuring with ${myconfig}"
	econf ${configuration} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/lib/${P}/info

	if use emacs ; then
		mv elisp/add-default.el ${T}/50gcl-gentoo.el
		elisp-site-file-install ${T}/50gcl-gentoo.el
		elisp-install ${PN} elisp/*
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
}

pkg_postinst() {

	use emacs && elisp-site-regen
}

pkg_postrm() {

	use emacs && elisp-site-regen
}
