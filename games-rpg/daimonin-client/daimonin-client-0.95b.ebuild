# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/daimonin-client/daimonin-client-0.95b.ebuild,v 1.2 2004/03/12 10:11:13 mr_bones_ Exp $

inherit games eutils flag-o-matic

DESCRIPTION="MMORPG with 2D isometric tiles grafik, true color and alpha blending effects"
HOMEPAGE="http://daimonin.sourceforge.net/"
SRC_URI="mirror://sourceforge/daimonin/dm_client_${PV/0.}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	virtual/x11"

S=${WORKDIR}/daimonin/client

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	cd make/linux
	append-flags -DGENTOO_DATADIR="'\"${GAMES_DATADIR}/${PN}\"'"
	emake EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	dogamesbin src/daimonin
	dodir ${GAMES_DATADIR}/${PN}
	cp -r bitmaps icons media sfx cache ${D}/${GAMES_DATADIR}/${PN}/
	insinto ${GAMES_DATADIR}/${PN}
	doins *.dat
	prepgamesdirs
}
