# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gish-demo/gish-demo-1.0.0.ebuild,v 1.11 2006/09/29 22:02:26 wolf31o2 Exp $

inherit eutils multilib games

DESCRIPTION="play as an amorphous ball of tar that rolls and squishes around"
HOMEPAGE="http://www.chroniclogic.com/gish.htm"
SRC_URI="ftp://demos.garagegames.com/gish/gishdemo-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
RESTRICT="strip"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/openal
	virtual/opengl
	media-libs/libvorbis
	amd64? (
		>=app-emulation/emul-linux-x86-xlibs-2.1
		>=app-emulation/emul-linux-x86-sdl-2.1 )"

S=${WORKDIR}/gishdemo

pkg_setup() {
	games_pkg_setup
	# Binary x86 package
	has_multilib_profile && ABI="x86"
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	cp -pPR * "${D}"/${dir}/
	games_make_wrapper gish ./gish-wrapper ${dir}

	# looks like when they built the game they accidently
	# linked it against openssl ... lets fake it
	dosym /$(get_libdir)/libc.so.6 ${dir}/libssl.so.4
	dosym /$(get_libdir)/libc.so.6 ${dir}/libcrypto.so.4
	exeinto ${dir}
	doexe ${FILESDIR}/gish-wrapper

	prepgamesdirs
}
