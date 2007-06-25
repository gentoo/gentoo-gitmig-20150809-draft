# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/monsterz/monsterz-0.7.0.ebuild,v 1.3 2007/06/25 15:50:32 jer Exp $

inherit eutils games

DESCRIPTION="a little puzzle game, similar to the famous Bejeweled or Zookeeper"
HOMEPAGE="http://sam.zoy.org/projects/monsterz/"
SRC_URI="http://sam.zoy.org/projects/monsterz/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-python/pygame"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		die "${PN} requires that media-libs/sdl-mixer be built with USE=mikmod"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		monsterz.py || die "sed failed"
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}
	insinto "${dir}"
	doins -r graphics sound || die "doins failed"
	newgamesbin monsterz.py ${PN} || die "newgamesbin failed"
	newicon graphics/icon.png ${PN}.png
	make_desktop_entry ${PN} Monsterz
	dodoc README AUTHORS TODO
	prepgamesdirs
}
