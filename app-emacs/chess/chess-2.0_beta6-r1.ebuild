# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/chess/chess-2.0_beta6-r1.ebuild,v 1.5 2009/03/29 21:23:38 ulm Exp $

inherit elisp

DESCRIPTION="A chess client and library for Emacs"
HOMEPAGE="http://emacs-chess.sourceforge.net/"
SRC_URI="mirror://sourceforge/emacs-chess/${P/_beta/b}.tar.gz
	mirror://gentoo/emacs-chess-sounds-2.0.tar.bz2
	mirror://gentoo/emacs-chess-pieces-2.0.tar.bz2"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( games-board/gnuchess
		games-board/crafty
		games-board/phalanx
		games-board/sjeng )"

S="${WORKDIR}/${PN}"
DOCS="ChangeLog EPD.txt PGN.txt PLAN README TODO"
ELISP_PATCHES="${PV}-chess-pos-move-gentoo.patch
	${PV}-chess-common-handler-gentoo.patch"
SITEFILE="50${PN}-gentoo.el"

# this is needed; elisp.eclass redefines src_compile() from portage default
src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp_src_install

	doinfo chess.info
	einfo "Installing sound files ..."
	insinto /usr/share/sounds/${PN}
	doins "${WORKDIR}"/sounds/*
	einfo "Installing pixmap files ..."
	insinto /usr/share/pixmaps/${PN}
	doins -r "${WORKDIR}"/pieces/*
}
