# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/daimonin-client/daimonin-client-0.96.5_beta3.ebuild,v 1.2 2004/11/03 00:30:43 vapier Exp $

inherit eutils flag-o-matic games

MY_PV=${PV/_beta*}
MY_PV=${MY_PV//.}
DESCRIPTION="MMORPG with 2D isometric tiles grafik, true color and alpha blending effects"
HOMEPAGE="http://daimonin.sourceforge.net/"
SRC_URI="mirror://sourceforge/daimonin/daimonin_client_src-BETA3-${MY_PV}a.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	virtual/x11"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/daimonin/client"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
	chmod a+x make/linux/configure
}

src_compile() {
	append-flags \
		-DGENTOO_DATADIR="'\"${GAMES_DATADIR}/${PN}\"'" \
		-DGENTOO_STATEDIR="'\"${GAMES_STATEDIR}/${PN}\"'"

	cd make/linux
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/daimonin || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}" "${GAMES_STATEDIR}/${PN}"
	cp -r bitmaps icons media sfx "${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"
	cp -r cache gfx_user srv_files "${D}/${GAMES_STATEDIR}/${PN}/" \
		|| die "cp failed"
	insinto "${GAMES_STATEDIR}/${PN}"
	doins *.{dat,p0} || die "doins failed"
	prepgamesdirs
	find "${D}/${GAMES_STATEDIR}/${PN}/" -type d -print0 | xargs -0 \
		chmod g+w
}
