# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trigger/trigger-0.5.2-r1.ebuild,v 1.6 2006/10/17 01:39:31 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils games

DESCRIPTION="Free OpenGL rally car racing game"
HOMEPAGE="http://www.positro.net/trigger/"
SRC_URI="http://files.scapecaster.com/posit/${P}-src.tar.bz2
	http://files.scapecaster.com/posit/${P}-data.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXt
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/openal
	media-libs/freealut
	dev-games/physfs"
DEPEND="${RDEPEND}
	x11-proto/xproto
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
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-physfs.patch
	AT_M4DIR=mk/autoconf eautoreconf
}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR}/${PN}" || die
	jam || die "jam failed"
}

src_install() {
	dogamesbin trigger || die "dogamesbin failed"

	cd ../${P}-data
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r events maps plugins sounds textures vehicles trigger.config.defs \
		|| die "doins failed"

	dodoc README.txt README-stereo.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "After running ${PN} for the first time, a config file is"
	elog "available in ~/.trigger/trigger.config"
	echo
}
