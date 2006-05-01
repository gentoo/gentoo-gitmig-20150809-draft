# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/burgerspace/burgerspace-1.8.1.ebuild,v 1.6 2006/05/01 01:12:00 mr_bones_ Exp $

inherit games

DESCRIPTION="Clone of the 1982 BurgerTime video game by Data East"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/burgerspace.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2
	media-libs/sdl-mixer
	dev-games/flatzebra"

src_install() {
	egamesinstall \
		docdir="${D}/usr/share/doc/${PF}" \
		desktopentrydir="${D}/usr/share/applications" \
		pixmapdir="${D}/usr/share/pixmaps" \
		|| die
	rm -f "${D}/usr/share/doc/${PF}"/{COPYING,INSTALL}
	prepalldocs
	prepgamesdirs
}
