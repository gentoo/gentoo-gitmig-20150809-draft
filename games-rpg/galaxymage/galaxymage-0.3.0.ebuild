# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/galaxymage/galaxymage-0.3.0.ebuild,v 1.3 2007/07/21 19:37:05 nyhm Exp $

inherit eutils games

DESCRIPTION="Tactical/strategic RPG with online multiplayer support"
HOMEPAGE="https://gna.org/projects/tactics"
SRC_URI="http://download.gna.org/tactics/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="psyco"

RDEPEND="dev-python/twisted
	>=dev-python/pyopengl-2.0.1
	dev-python/numeric
	dev-python/pygame
	psyco? ( dev-python/psyco )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_LIBDIR@:$(games_get_libdir)/${PN}:" \
		GalaxyMage.py || die "sed for setting source dir failed"
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		src/Translate.py \
		src/Resources.py || die "sed for setting data dir failed"
}

src_install() {
	newgamesbin GalaxyMage.py ${PN} || die "newgamesbin failed"

	insinto "$(games_get_libdir)"/${PN}
	doins -r src/* || die "doins src failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r locale data/* || die "doins data failed"

	dodoc CREDITS.txt README.txt
	dohtml -r doc

	newicon data/core/images/icon-32.png ${PN}.png
	make_desktop_entry ${PN} GalaxyMage
	prepgamesdirs
}
