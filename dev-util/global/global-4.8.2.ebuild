# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/global/global-4.8.2.ebuild,v 1.2 2005/03/20 18:51:11 weeve Exp $

inherit elisp

DESCRIPTION="GNU Global is a tag system to find the locations of a specified object in C, C++, Yacc, Java and assembler sources."
HOMEPAGE="http://www.gnu.org/software/global/global.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc vim emacs"
DEPEND="virtual/libc
	doc? ( sys-apps/texinfo )
	vim? ( app-editors/vim )
	emacs? ( virtual/emacs )"

SITEFILE=50gtags-gentoo.el

src_compile() {
	econf || die "econf failed"

	if use doc; then
		texi2pdf -q -o doc/global.pdf doc/global.txi
		texi2html -o doc/global.html doc/global.txi
	fi

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	if use doc; then
		dohtml doc/global.html
		dodoc  doc/global.pdf
	fi
	dodoc AUTHORS LICENSE FAQ INSTALL NEWS README THANKS

	insinto /etc
	doins gtags.conf
	insinto /usr/share/${PN}
	doins gtags.pl globash.rc

	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins gtags.vim
	fi

	if use emacs; then
	    cp gtags.el ${SITEFILE}
	    elisp-site-file-install ${SITEFILE}
	fi
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi
}

pkg_postrm() {
	if use emacs; then
		elisp-site-regen
	fi
}
