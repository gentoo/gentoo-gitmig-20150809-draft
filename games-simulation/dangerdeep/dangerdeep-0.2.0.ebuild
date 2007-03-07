# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/dangerdeep/dangerdeep-0.2.0.ebuild,v 1.5 2007/03/07 08:19:29 mr_bones_ Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="a World War II German submarine simulation"
HOMEPAGE="http://www.dangerdeep.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${PN}-data-${PV}.zip"

LICENSE="GPL-2 CCPL-Attribution-NonCommercial-NoDerivs-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse debug"

RDEPEND="virtual/opengl
	virtual/glu
	sci-libs/fftw
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/scons"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
	sed -i \
		-e "/console_log.txt/ s:fopen.*:stderr;:" \
		src/system.cpp \
		|| die "sed failed"
}

src_compile() {
	local sse=-1
	local use_debug=0

	if use sse ; then
		use amd64 && sse=3 || sse=1
	fi

	if use debug ; then
		use_debug=1
	fi

	scons \
		usex86sse=${sse} \
		datadir="${GAMES_DATADIR}"/${PN} \
		debug=${use_debug} \
		|| die "scons failed"
}

src_install() {
	dogamesbin build/linux/${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../data/* || die "doins failed"

	newicon logo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Danger from the Deep" ${PN}.xpm

	dodoc ChangeLog CREDITS *README*
	doman doc/man/${PN}.6

	prepgamesdirs
}
