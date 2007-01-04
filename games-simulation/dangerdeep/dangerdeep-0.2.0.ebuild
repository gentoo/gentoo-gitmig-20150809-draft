# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/dangerdeep/dangerdeep-0.2.0.ebuild,v 1.1 2007/01/04 04:37:35 mr_bones_ Exp $

inherit eutils debug toolchain-funcs games

DESCRIPTION="a World War II German submarine simulation"
HOMEPAGE="http://www.dangerdeep.net/"
SRC_URI="mirror://sourceforge/${PN}/dangerdeep-${PV}.tar.gz
	mirror://sourceforge/${PN}/dangerdeep-data-${PV}.zip"

LICENSE="GPL-2 CCPL-Attribution-NonCommercial-NoDerivs-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="sse"

RDEPEND="virtual/opengl
	virtual/glu
	sci-libs/fftw
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	dev-util/scons"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/data "${S}" || die "mv failed"
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
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
		DESTDIR="${D}" \
		--cache-disable \
		|| die "scons failed"
}

src_install() {
	dogamesbin build/linux/${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"

	newicon logo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Danger from the Deep" ${PN}.xpm

	dodoc ChangeLog CREDITS *README*
	doman doc/man/${PN}.6

	prepgamesdirs
}
