# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gish-demo/gish-demo-1.0.0.ebuild,v 1.1 2004/12/08 04:35:13 vapier Exp $

inherit games eutils

DESCRIPTION="play as an amorphous ball of tar that rolls and squishes around"
HOMEPAGE="http://www.chroniclogic.com/gish.htm"
SRC_URI="ftp://demos.garagegames.com/gish/gishdemo-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/libc
	media-libs/libsdl
	media-libs/openal
	virtual/opengl
	media-libs/libvorbis"

S=${WORKDIR}/gishdemo

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	cp -a * "${D}"/${dir}/
	games_make_wrapper gish ./gish-wrapper ${dir}

	# looks like when they built the game they accidently
	# linked it against openssl ... lets fake it
	dosym /lib/libc.so.6 ${dir}/libssl.so.4
	dosym /lib/libc.so.6 ${dir}/libcrypto.so.4
	exeinto ${dir}
	doexe ${FILESDIR}/gish-wrapper

	prepgamesdirs
}
