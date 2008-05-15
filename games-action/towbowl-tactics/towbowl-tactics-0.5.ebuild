# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/towbowl-tactics/towbowl-tactics-0.5.ebuild,v 1.10 2008/05/15 12:34:00 nyhm Exp $

inherit eutils games

DESCRIPTION="Tow Bowl Tactics is a game based on Games Workshop's Blood Bowl"
HOMEPAGE="http://www.towbowltactics.com/index_en.html"
SRC_URI="http://www.towbowltactics.com/download/tbt.${PV}.src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	media-libs/smpeg
	media-libs/sdl-net
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/tbt/src"

src_unpack() {
	local f

	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/<language>0/<language>1/g" ../config.xml \
			|| die "sed config.xml failed"
	sed -i \
		-e "/^CFLAGS/ s:-O2 -g -fno-strength-reduce -Wall -W:${CFLAGS}:" \
	    -e "/^TBTHOME/ s:/.*:${GAMES_DATADIR}/tbt:" Makefile \
			|| die "sed Makefile failed"
	sed -i \
		-e "/tbt.ico/ s:\"\./:TBTHOME \"/:" Main.cpp \
			|| die "sed Main.cpp failed"
	sed -i \
		-e "s:TBTHOME \"/config.xml:\"${GAMES_SYSCONFDIR}/tbt/config.xml:g" \
			global.h || die "sed global,h failed"

	for f in $(find "${S}" -type f)
	do
		edos2unix ${f}
	done
}

src_install() {
	dogamesbin tbt || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/tbt"
	cp -r ../data ../tbt.ico "${D}${GAMES_DATADIR}/tbt" || die "cp failed"
	insinto "${GAMES_SYSCONFDIR}/tbt"
	doins ../config.xml || die "doins failed"
	prepgamesdirs
}
