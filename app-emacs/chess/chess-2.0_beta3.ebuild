# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/chess/chess-2.0_beta3.ebuild,v 1.7 2004/09/03 00:40:57 dholm Exp $

inherit elisp

DESCRIPTION="A chess client and library for Emacs"
HOMEPAGE="http://emacs-chess.sourceforge.net/"
SRC_URI="mirror://sourceforge/emacs-chess/${P/_beta/b}.tar.bz2
	mirror://gentoo/emacs-chess-sounds-2.0.tar.bz2
	mirror://gentoo/emacs-chess-pieces-2.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	games-board/gnuchess"

S="${WORKDIR}/${P/_beta/b}"

SITEFILE=50chess-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S} && rm -f *.elc
}

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	cp -r ${S}/../pieces ${S}/../sounds ${D}/${SITELISP}/${PN}

	doinfo chess.info
	dohtml *.html
	dodoc ChangeLog EPD.txt PGN.txt PLAN README TODO
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
