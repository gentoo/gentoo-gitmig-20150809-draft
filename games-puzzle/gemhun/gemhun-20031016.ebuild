# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemhun/gemhun-20031016.ebuild,v 1.1 2003/11/08 17:13:04 vapier Exp $

inherit games

DESCRIPTION="A puzzle game about grouping gems of a chosen amount together"
HOMEPAGE="http://gemhun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemhun/GemHunters-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="dev-games/kyra
	>=media-libs/sdl-mixer-1.2.1
	virtual/x11"

S=${WORKDIR}/GemHunters

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
