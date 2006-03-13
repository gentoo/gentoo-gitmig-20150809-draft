# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/daimonin-client/daimonin-client-0.95b-r2.ebuild,v 1.8 2006/03/13 21:18:36 mr_bones_ Exp $

inherit eutils flag-o-matic games

MY_PV=95b2
DESCRIPTION="MMORPG with 2D isometric tiles grafik, true color and alpha blending effects"
HOMEPAGE="http://daimonin.sourceforge.net/"
SRC_URI="mirror://sourceforge/daimonin/dm_client_${MY_PV}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="X"

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/daimonin/client"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
}

src_compile() {
	cd make/linux
	append-flags -DGENTOO_DATADIR="'\"${GAMES_DATADIR}/${PN}\"'"
	emake EXTRA_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin src/daimonin
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r bitmaps icons media sfx cache "${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins *.dat
	prepgamesdirs
}
