# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/global/global-5.3.ebuild,v 1.2 2007/08/27 17:15:47 armin76 Exp $

inherit elisp-common

DESCRIPTION="GNU Global is a tag system to find the locations of a specified object in C, C++, Yacc, Java and assembler sources."
HOMEPAGE="http://www.gnu.org/software/global/global.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
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

	if use emacs; then
		elisp-comp *.el || die
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
		elisp-install gtags *.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
