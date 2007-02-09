# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/chess/chess-2.0_beta5-r1.ebuild,v 1.1 2007/02/09 00:26:28 opfer Exp $

inherit elisp-common eutils

DESCRIPTION="A chess client and library for Emacs"
HOMEPAGE="http://emacs-chess.sourceforge.net/"
SRC_URI="mirror://sourceforge/emacs-chess/${P/_beta/b}.tar.bz2
	mirror://gentoo/emacs-chess-sounds-2.0.tar.bz2
	mirror://gentoo/emacs-chess-pieces-2.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="festival"

# don't forget to change it back to app-editors/emacs
# (inherit elisp.eclass)!  See bug 151474
DEPEND="app-editors/emacs-cvs"

RDEPEND="${DEPEND}
	games-board/gnuchess
	festival? ( app-accessibility/festival ) "

S="${WORKDIR}/${P/_beta/b}"

SITEFILE=50chess-gentoo.el

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-byte-compiling-files-gentoo.patch" || die
	cd "${S}" && rm -f *.elc
}

src_compile() {
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	cp -r "${S}/../pieces" "${S}/../sounds" "${D}/${SITELISP}/${PN}"
	doinfo chess.info
	dohtml *.html
	dodoc ChangeLog EPD.txt PGN.txt PLAN README TODO
}
