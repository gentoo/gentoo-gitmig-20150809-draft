# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/galaxymage/galaxymage-0.3.0.ebuild,v 1.1 2007/04/19 06:15:55 tupone Exp $

inherit eutils games

DESCRIPTION="Tactical/strategic RPG"
HOMEPAGE="http://www.galaxymage.org"
SRC_URI="http://download.gna.org/tactics/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="psyco"

DEPEND="dev-python/twisted
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
	dogamesbin GalaxyMage.py

	insinto $(games_get_libdir)/${PN}
	doins -r src/* || die "Install source failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r locale data/* || die "Install data failed"

	dodoc CREDITS.txt README.txt || die "Install doc failed"
	dohtml -r doc || die "Install of html doc failed"

	make_desktop_entry "${GAMES_BINDIR}/GalaxyMage.py" GalaxyMage
	prepgamesdirs
}
