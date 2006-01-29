# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trigger/trigger-0.5.1c.ebuild,v 1.4 2006/01/29 08:04:42 joshuabaergen Exp $

inherit eutils games

PSOURCE="${P}-src"
PDATA="${P}-data"
DESCRIPTION="free OpenGL rally car racing game"
HOMEPAGE="http://www.positro.net/trigger/"
SRC_URI="http://files.scapecaster.com/posit/${PSOURCE}.tar.bz2
	http://files.scapecaster.com/posit/${PDATA}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	|| (
		( x11-libs/libX11 )
		virtual/x11 )
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2
	media-libs/openal
	dev-games/physfs"
DEPEND="${RDEPEND}
	|| (
		( x11-libs/libXt
			x11-proto/xproto )
		virtual/x11
	)
	dev-util/jam"

S=${WORKDIR}/${PSOURCE}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glx-check.patch
}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR}/${PN}" || die
	jam || "jam failed"
}

src_install() {
	dogamesbin trigger || die "dogamesbin failed"

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r ../${PDATA}/{events,maps,plugins,sounds,textures,vehicles,trigger.config.defs} \
		"${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"

	dodoc ../${PDATA}/{README.txt,README-stereo.txt}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "After running ${PN} for the first time, a config file is"
	einfo "available in ~/.trigger/trigger.config"
	echo
}
