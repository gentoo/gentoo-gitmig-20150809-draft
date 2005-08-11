# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/conveysdl/conveysdl-1.ebuild,v 1.3 2005/08/11 23:55:24 tester Exp $

inherit games

DESCRIPTION="Guide the blob along the conveyer belt collecting the red blobs, if you miss any you go round again"
HOMEPAGE="http://www.cloudsprinter.com/software/conveysdl/"
# No upstream version
#SRC_URI="http://www.cloudsprinter.com/software/conveysdl/${PN}.tar"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.7
	>=media-libs/sdl-mixer-1.2.5"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	find gfx sounds levels -type f -exec chmod a-x \{\} \;

	# Patch paths and use our CFLAGS
	sed -i \
		-e "s:\"\":\"\$(datadir)/\":" \
		-e "s:-Wall:-Wall ${CFLAGS}:" \
		Makefile || die "sed Makefile failed"

	# Incomplete readme
	sed -i \
		-e 's:I k:use -nosound to disable sound\n\nI k:' \
		readme || die "sed readme failed"

	sed -i \
		-e 's:SDL_Mi:SDL_mi:' \
		src/main.c || die "sed main.c failed"
}

src_compile() {
	emake datadir="${GAMES_DATADIR}/${PN}" || die "emake failed"
}

src_install() {
	dogamesbin conveysdl || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r gfx sounds levels "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc readme
	prepgamesdirs
}
