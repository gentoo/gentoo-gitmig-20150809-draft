# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemhun/gemhun-20031016.ebuild,v 1.3 2004/03/31 19:04:33 mr_bones_ Exp $

inherit eutils flag-o-matic games

S="${WORKDIR}/GemHunters"
DESCRIPTION="A puzzle game about grouping gems of a chosen amount together"
HOMEPAGE="http://gemhun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemhun/GemHunters-src-${PV}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-games/kyra
	>=media-libs/sdl-mixer-1.2.1
	virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

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
