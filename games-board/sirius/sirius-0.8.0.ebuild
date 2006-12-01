# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/sirius/sirius-0.8.0.ebuild,v 1.7 2006/12/01 21:43:41 wolf31o2 Exp $

inherit games

DESCRIPTION="A program for playing the game of othello"
HOMEPAGE="http://sirius.bitvis.nu/"
SRC_URI="http://sirius.bitvis.nu/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*
	=gnome-base/gconf-2*
	gnome-base/libgnomeui
	gnome-base/libgnomecanvas"

src_install() {
	egamesinstall || die
	dodoc AUTHORS BUGS ChangeLog README
	prepgamesdirs
}
