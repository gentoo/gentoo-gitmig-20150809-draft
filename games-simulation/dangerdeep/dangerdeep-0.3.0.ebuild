# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/dangerdeep/dangerdeep-0.3.0.ebuild,v 1.5 2009/01/20 06:00:29 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="a World War II German submarine simulation"
HOMEPAGE="http://dangerdeep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${PN}-data-${PV}.zip"

LICENSE="GPL-2 CCPL-Attribution-NonCommercial-NoDerivs-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse debug"

RDEPEND="virtual/opengl
	virtual/glu
	sci-libs/fftw:3.0
	media-libs/libsdl
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/scons"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e "/console_log.txt/ s:fopen.*:stderr;:" \
		src/system.cpp \
		|| die "sed failed"
}

src_compile() {
	local sse=-1

	if use sse ; then
		use amd64 && sse=3 || sse=1
	fi

	scons \
		usex86sse=${sse} \
		datadir="${GAMES_DATADIR}"/${PN} \
		$(use debug && echo debug=1) \
		|| die "scons failed"
}

src_install() {
	dogamesbin build/linux/${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../data/* || die "doins failed"

	newicon dftd_icon.png ${PN}.png
	make_desktop_entry ${PN} "Danger from the Deep"

	dodoc ChangeLog CREDITS README
	doman doc/man/${PN}.6

	prepgamesdirs
}
