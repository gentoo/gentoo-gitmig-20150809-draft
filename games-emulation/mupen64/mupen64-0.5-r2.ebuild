# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.5-r2.ebuild,v 1.1 2007/02/14 14:27:57 nyhm Exp $

inherit eutils multilib games

MY_P=${PN}_src-${PV}
DESCRIPTION="A Nintendo 64 (N64) emulator"
HOMEPAGE="http://mupen64.emulation64.com/"
SRC_URI="http://mupen64.emulation64.com/files/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""

RDEPEND="virtual/opengl
	>=x11-libs/gtk+-2
	media-libs/libsdl
	media-libs/sdl-ttf
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-sdl
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!games-emulation/mupen64-blight-input
	!games-emulation/mupen64-glN64
	!games-emulation/mupen64-jttl_sound"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f plugins/empty blight_input/SDL_ttf*

	epatch \
		"${FILESDIR}"/${P}-paths.patch \
		"${FILESDIR}"/${P}-sdl-ttf.patch

	sed -i "s:#undef WITH_HOME:#define WITH_HOME \"${GAMES_PREFIX}/\":" \
		config.h \
		|| die "sed failed"

	sed -i \
		-e '/strip/d' \
		-e "s:CFLAGS[[:space:]]*=\(.*\):CFLAGS=-fPIC ${CFLAGS}:" \
		-e "s:CXXFLAGS[[:space:]]*=\(.*\):CXXFLAGS=-fPIC ${CXXFLAGS}:" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	use amd64 && multilib_toolchain_setup x86

	local t
	for t in \
		mupen64 \
		mupen64_nogui \
		plugins/mupen64_input.so \
		plugins/blight_input.so \
		plugins/mupen64_hle_rsp_azimer.so \
		plugins/dummyaudio.so \
		plugins/mupen64_audio.so \
		plugins/jttl_audio.so \
		plugins/mupen64_soft_gfx.so \
		plugins/glN64.so
	do
		emake ${t} || die "emake ${t} failed"
	done
}

src_install() {
	dogamesbin mupen64 mupen64_nogui || die "dogamesbin failed"

	insinto "${GAMES_LIBDIR}"/${PN}
	doins -r mupen64.ini jttl_audio.conf lang roms plugins || die "doins failed"

	dodoc *.txt doc/readme.pdf
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "If you are upgrading from a previous version of mupen64,"
	ewarn "backup your saved games then run rm -rf on your"
	ewarn ".mupen64 directory. After launching the new version, copy"
	ewarn "your saved games to their original place."
	echo
}
