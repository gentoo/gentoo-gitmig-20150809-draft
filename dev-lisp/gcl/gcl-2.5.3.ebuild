# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.5.3.ebuild,v 1.6 2004/05/28 12:36:11 vapier Exp $

inherit elisp-common flag-o-matic

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI="ftp://ftp.gnu.org/gnu/gcl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="emacs"

DEPEND=">=app-text/texi2html-1.64
	>=dev-libs/gmp-4.1
	virtual/tetex"
RDEPEND="${DEPEND}
	emacs? ( virtual/emacs )"
# uncomment and add to profiles when GCL is integrated into the common lisp controller
# PROVIDE="virtual/commonlisp"

src_unpack() {
	unpack ${A}
	sed -e "s/gcl-doc/${PF}/g" ${S}/info/makefile > ${T}/makefile
	mv ${T}/makefile ${S}/info/makefile
}

src_compile() {
	# hardened gcc may automatically use PIE building,
	# which does not work for this package so far
	filter-flags "-fPIC"

	econf --enable-locbfd \
		--disable-statsysbfd \
		--enable-readline \
		--enable-infodir=/usr/share/info \
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl \
		|| die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/lib/${P}/info

	if [ -n "`use emacs`" ] ; then
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
