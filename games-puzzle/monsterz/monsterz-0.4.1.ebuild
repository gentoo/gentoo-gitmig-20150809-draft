# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/monsterz/monsterz-0.4.1.ebuild,v 1.2 2005/03/19 04:08:00 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="a little puzzle game, similar to the famous Bejeweled or Zookeeper"
HOMEPAGE="http://sam.zoy.org/projects/monsterz/"
SRC_URI="http://sam.zoy.org/projects/monsterz/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
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
		-e "s:GENTOO_SCOREFILE:${GAMES_STATEDIR}/${PN}.scores:" \
		monsterz.py || die
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}
	insinto "${dir}"
	doins *.wav *.s3m *.png || die "doins failed"
	newgamesbin monsterz.py ${PN} || die "dobin failed"
	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}"/${PN}.scores
	dodoc README AUTHORS TODO INSTALL
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}"/${PN}.scores
}
