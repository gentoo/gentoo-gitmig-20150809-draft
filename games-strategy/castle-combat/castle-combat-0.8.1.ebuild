# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/castle-combat/castle-combat-0.8.1.ebuild,v 1.6 2009/01/25 21:47:00 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A clone of the old arcade game Rampart"
HOMEPAGE="http://www.linux-games.com/castle-combat/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-python/twisted
	media-libs/sdl-mixer[mikmod]
	dev-python/pygame"

src_prepare() {
	sed -i "s:src:$(games_get_libdir)/${PN}:" ${PN}.py \
		|| die "sed ${PN}.py failed"
	sed -i "/data_path =/s:\"data:\"${GAMES_DATADIR}/${PN}:" src/common.py \
		|| die "sed common.py failed"
}

src_install() {
	newgamesbin ${PN}.py ${PN} || die "newgamesbin failed"
	insinto "$(games_get_libdir)"/${PN}
	doins src/* || die "doins src failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/{colourba.ttf,gfx,sound} || die "doins data failed"
	newicon data/gfx/castle.png ${PN}.png
	make_desktop_entry ${PN} Castle-Combat
	dohtml data/font_read_me.html data/doc/rules.html
	dodoc TODO
	prepgamesdirs
}
