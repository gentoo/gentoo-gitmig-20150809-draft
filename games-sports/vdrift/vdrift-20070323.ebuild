# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/vdrift/vdrift-20070323.ebuild,v 1.1 2007/07/25 15:05:05 nyhm Exp $

inherit eutils toolchain-funcs games

MY_P=${PN}-${PV:0:4}-${PV:4:2}-${PV:6}
DESCRIPTION="A driving simulation made with drift racing in mind"
HOMEPAGE="http://vdrift.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.bz2
	minimal? ( mirror://sourceforge/${PN}/${MY_P}-data-minimal.tar.bz2 )
	!minimal? ( mirror://sourceforge/${PN}/${MY_P}-data-full.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="minimal nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/freealut
	media-libs/libsdl
	media-libs/openal
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-net
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/scons
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/build/${MY_P}-src

src_unpack() {
	unpack ${MY_P}-src.tar.bz2
	cd build
	if use minimal ; then
		unpack ${MY_P}-data-minimal.tar.bz2
	else
		unpack ${MY_P}-data-full.tar.bz2
	fi
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc42.patch
	sed -i '/-O2/d' SConstruct || die "sed failed"
}

src_compile() {
	tc-export CC CXX
	scons \
		NLS=$(use nls && echo 1 || echo 0) \
		destdir="${D}" \
		bindir="${GAMES_BINDIR}" \
		datadir="${GAMES_DATADIR}"/${PN} \
		localedir=/usr/share/locale \
		prefix= \
		use_binreloc=0 \
		release=1 \
		os_cc=1 \
		os_cxx=1 \
		os_cxxflags=1 \
		|| die "scons failed"
}

src_install() {
	scons install || die "scons install failed"
	newicon data/textures/icons/vdrift-64x64.png ${PN}.png
	make_desktop_entry ${PN} VDrift
	dodoc docs/*
	prepgamesdirs
}
