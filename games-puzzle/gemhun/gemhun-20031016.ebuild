# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemhun/gemhun-20031016.ebuild,v 1.2 2004/02/03 21:30:44 mr_bones_ Exp $

inherit eutils games

S="${WORKDIR}/GemHunters"
DESCRIPTION="A puzzle game about grouping gems of a chosen amount together"
HOMEPAGE="http://gemhun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemhun/GemHunters-src-${PV}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-games/kyra
	>=media-libs/sdl-mixer-1.2.1
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	append-flags -DGENTOO_DATADIR="'\"${GAMES_DATADIR}/${PN}/\"'"
	sed -i "s:-O3:${CFLAGS}:" src/makefile.unix
}

src_compile() {
	export SDL_VIDEODRIVER="dummy"
	emake || die "emake failed"
}

src_install() {
	dogamesbin unix/*/gemhun
	local datadir=${GAMES_DATADIR}/${PN}
	dodir ${datadir}
	cp -r data/* ${D}/${datadir}/
	find ${D}/${datadir} -name makefile -exec rm '{}' \;
	dodoc changelog readme todo
	prepgamesdirs
}
