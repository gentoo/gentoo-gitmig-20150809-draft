# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemhun/gemhun-20031016.ebuild,v 1.6 2006/03/06 20:22:27 tupone Exp $

inherit eutils flag-o-matic games

S="${WORKDIR}/GemHunters"
DESCRIPTION="A puzzle game about grouping gems of a chosen amount together"
HOMEPAGE="http://gemhun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemhun/GemHunters-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="dev-games/kyra
	>=media-libs/sdl-mixer-1.2.1
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	append-flags -DGENTOO_DATADIR="'\"${GAMES_DATADIR}/${PN}/\"'"
	sed -i \
		-e "s:-O3:${CFLAGS}:" src/makefile.unix \
			|| die "sed src/makefile.unix failed"
}

src_compile() {
	export SDL_VIDEODRIVER="dummy"
	emake || die "emake failed"
}

src_install() {
	local datadir="${GAMES_DATADIR}/${PN}"

	dogamesbin unix/*/gemhun || die "dogamesbin failed"
	dodir "${datadir}"
	cp -r data/* "${D}/${datadir}/" || die "cp failed"
	find "${D}/${datadir}" -name makefile -exec rm '{}' \;
	dodoc changelog readme todo
	prepgamesdirs
}
