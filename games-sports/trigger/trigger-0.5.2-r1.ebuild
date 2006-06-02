# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trigger/trigger-0.5.2-r1.ebuild,v 1.3 2006/06/02 00:04:02 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Free OpenGL rally car racing game"
HOMEPAGE="http://www.positro.net/trigger/"
SRC_URI="http://files.scapecaster.com/posit/${P}-src.tar.bz2
	http://files.scapecaster.com/posit/${P}-data.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/opengl
	|| (
		( x11-libs/libX11 )
		virtual/x11 )
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2
	media-libs/sdl-mixer
	~media-libs/openal-0.0.8
	media-libs/freealut
	dev-games/physfs"
DEPEND="${RDEPEND}
	|| (
		( x11-libs/libXt
			x11-proto/xproto )
		virtual/x11
	)
	dev-util/jam"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:#include <GL/glew.h>:#include "glew.h":' \
		-e 's:include <GL/glxew.h>:include "glxew.h":' \
		src/glew/glew.cpp \
		src/glew/GL/glxew.h \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-freealut.patch \
		"${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	./autogen.sh
	egamesconf --datadir="${GAMES_DATADIR}/${PN}" || die
	jam || die "jam failed"
}

src_install() {
	dogamesbin trigger || die "dogamesbin failed"

	cd ../${P}-data
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r events maps plugins sounds textures vehicles trigger.config.defs

	dodoc README.txt README-stereo.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "After running ${PN} for the first time, a config file is"
	einfo "available in ~/.trigger/trigger.config"
	echo
}
