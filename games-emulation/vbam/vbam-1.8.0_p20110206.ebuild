# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/vbam/vbam-1.8.0_p20110206.ebuild,v 1.2 2011/02/09 20:31:07 radhermit Exp $

EAPI=2

inherit confutils cmake-utils eutils games

DESCRIPTION="Game Boy, GBC, and GBA emulator forked from VisualBoyAdvance"
HOMEPAGE="http://vba-m.ngemu.com"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk lirc +sdl"

RDEPEND=">=media-libs/libpng-1.4
	media-libs/libsdl[joystick]
	media-libs/libsfml
	sys-libs/zlib
	virtual/opengl
	gtk? ( >=dev-cpp/libglademm-2.4.0:2.4
		>=dev-cpp/glibmm-2.4.0:2
		>=dev-cpp/gtkmm-2.4.0:2.4
		>=dev-cpp/gtkglextmm-1.2.0 )
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	confutils_require_any sdl gtk
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cflags.patch \
		"${FILESDIR}"/${P}-disable-asm.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_no sdl SDL)
		$(cmake-utils_use_no gtk GTK)
		$(cmake-utils_use_with lirc LIRC)
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use sdl ; then
		dodoc doc/ReadMe.SDL.txt
		doman debian/vbam.1
	fi
	prepgamesdirs
}
