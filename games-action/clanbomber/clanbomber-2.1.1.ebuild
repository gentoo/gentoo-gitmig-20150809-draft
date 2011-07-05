# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-2.1.1.ebuild,v 1.1 2011/07/05 05:40:33 tupone Exp $

EAPI=2

inherit base eutils games

DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://savannah.nongnu.org/projects/clanbomber/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/sdl-image
	media-libs/sdl-ttf
	media-libs/sdl-gfx"
RDEPEND="${DEPEND}
	dev-libs/boost"

DOCS=( AUTHORS ChangeLog ChangeLog.hg IDEAS LICENSE.DEJAVU NEWS QUOTES README
	TODO )

src_install() {
	base_src_install
	newicon src/pics/cup2.png ${PN}.png
	make_desktop_entry ${PN}2 ClanBomber2
	prepgamesdirs
}
