# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64/mupen64-0.5-r4.ebuild,v 1.2 2007/04/02 15:23:58 nyhm Exp $

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
		>=app-emulation/emul-linux-x86-sdl-10.0
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	has_multilib_profile && multilib_toolchain_setup x86
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f plugins/empty blight_input/SDL_ttf*

	epatch \
		"${FILESDIR}"/${P}-anisotropic.patch \
		"${FILESDIR}"/${P}-gentoo3.patch \
		"${FILESDIR}"/${PN}-glN64-ucode.patch \
		"${FILESDIR}"/${PN}-glN64-noasmfix.patch

	sed -i \
		-e "s:#undef WITH_HOME:#define WITH_HOME \"$(games_get_libdir)/\":" \
		-e "s:#undef SHARE:#define SHARE \"$(games_get_libdir)/${PN}/\":" \
		config.h \
		|| die "sed failed"
}

src_compile() {
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

	insinto "$(games_get_libdir)/${PN}"
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
