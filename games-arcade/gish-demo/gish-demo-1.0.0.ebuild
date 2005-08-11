# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gish-demo/gish-demo-1.0.0.ebuild,v 1.3 2005/08/11 20:32:37 flameeyes Exp $

inherit games eutils

DESCRIPTION="play as an amorphous ball of tar that rolls and squishes around"
HOMEPAGE="http://www.chroniclogic.com/gish.htm"
SRC_URI="ftp://demos.garagegames.com/gish/gishdemo-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

RDEPEND="virtual/libc
	media-libs/libsdl
	media-libs/openal
	virtual/opengl
	media-libs/libvorbis
	amd64? (
		>=app-emulation/emul-linux-x86-xlibs-2.1
		>=app-emulation/emul-linux-x86-sdl-2.1
	)"

pkg_setup() {
	# Binary x86 package
	has_multilib_profile && ABI="x86"
}

S=${WORKDIR}/gishdemo

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	cp -a * "${D}"/${dir}/
	games_make_wrapper gish ./gish-wrapper ${dir}

	# looks like when they built the game they accidently
	# linked it against openssl ... lets fake it
	dosym /$(get_libdir)/libc.so.6 ${dir}/libssl.so.4
	dosym /$(get_libdir)/libc.so.6 ${dir}/libcrypto.so.4
	exeinto ${dir}
	doexe ${FILESDIR}/gish-wrapper

	prepgamesdirs
}
