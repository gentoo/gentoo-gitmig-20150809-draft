# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/secondlife-bin/secondlife-bin-1.22_rc5.ebuild,v 1.2 2009/01/08 11:29:48 lavajoe Exp $

inherit eutils multilib games versionator

SECONDLIFE_REVISION=107013
SECONDLIFE_MAJOR_VER=$(get_version_component_range 1-2)
SECONDLIFE_MINOR_VER=$(get_version_component_range 3)
SECONDLIFE_MINOR_VER=${SECONDLIFE_MINOR_VER/rc/}
MY_P="SecondLife-i686-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}.${SECONDLIFE_REVISION}"

DESCRIPTION="The Second Life (an online, 3D virtual world) viewer"
HOMEPAGE="http://secondlife.com/"
SRC_URI="http://release-candidate-secondlife-com.s3.amazonaws.com/${MY_P}.tar.bz2"
RESTRICT="mirror strip"

LICENSE="GPL-2-with-Linden-Lab-FLOSS-exception"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# Note, used to RDEPEND on:
# media-fonts/kochi-substitute
RDEPEND="sys-libs/glibc
	x86? (
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		dev-libs/libgcrypt
		dev-libs/libgpg-error
		dev-libs/openssl
		media-libs/freetype
		media-libs/libogg
		media-libs/libsdl
		media-libs/libvorbis
		net-libs/gnutls
		net-misc/curl
		sys-libs/zlib
		virtual/glu
		virtual/opengl
	)
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-gtklibs
	)"

S="${WORKDIR}/${MY_P}"

SECONDLIFE_HOME="${GAMES_PREFIX_OPT}/secondlife"

QA_TEXTRELS="${SECONDLIFE_HOME:1}/bin/libllkdu.so
	${SECONDLIFE_HOME:1}/lib/libkdu_v42R.so
	${SECONDLIFE_HOME:1}/lib/libfmod-3.75.so
	${SECONDLIFE_HOME:1}/lib/libvivoxsdk.so
	${SECONDLIFE_HOME:1}/app_settings/mozilla-runtime-linux-i686/libxul.so"
QA_EXECSTACK="${SECONDLIFE_HOME:1}/bin/do-not-directly-run-secondlife-bin
	${SECONDLIFE_HOME:1}/bin/libllkdu.so
	${SECONDLIFE_HOME:1}/lib/libSDL-1.2.so.0
	${SECONDLIFE_HOME:1}/lib/libcrypto.so.0.9.7
	${SECONDLIFE_HOME:1}/lib/libkdu_v42R.so
	${SECONDLIFE_HOME:1}/lib/libfmod-3.75.so
	${SECONDLIFE_HOME:1}/app_settings/mozilla-runtime-linux-i686/libxul.so"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"
}

src_install() {
	exeinto "${SECONDLIFE_HOME}"
	doexe launch_url.sh linux-crash-logger.bin secondlife || die
	rm -rf launch_url.sh linux-crash-logger.bin secondlife

	exeinto "${SECONDLIFE_HOME}"/bin
	doexe bin/* || die
	rm -rf bin

	exeinto "${SECONDLIFE_HOME}"/lib
	doexe lib/* || die
	rm -rf lib

	insinto "${SECONDLIFE_HOME}"
	doins -r * || die "doins * failed"

	#dosym /usr/share/fonts/kochi-substitute/kochi-mincho-subst.ttf "${SECONDLIFE_HOME}"/unicode.ttf

	games_make_wrapper secondlife-bin "./secondlife --set VersionChannelName Gentoo" "${SECONDLIFE_HOME}" "${SECONDLIFE_HOME}"/lib
	make_desktop_entry secondlife-bin "Second Life" /opt/secondlife/secondlife_icon.png

	prepgamesdirs
}
