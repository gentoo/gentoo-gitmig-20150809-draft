# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal/unreal-226.ebuild,v 1.1 2003/09/09 18:10:15 vapier Exp $

inherit games eutils

DESCRIPTION="Futuristic FPS (a hack that runs on top of Unreal Tournament)"
HOMEPAGE="http://www.unreal.com/"
SRC_URI="http://www.icculus.org/%7Echunky/ut/unreal/unreali-install.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="X"

DEPEND="|| ( app-games/unreal-tournament app-games/unreal-tournament-goty )
	sys-libs/lib-compat"
RDEPEND="X? ( virtual/x11 )
	opengl? ( virtual/opengl )"

S=${WORKDIR}

pkg_setup() {
	games_get_cd System/
	games_verify_cd ${PN}
	games_pkg_setup
}

src_unpack() {
	unpack_makeself ${A}
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/unreal
	dodir ${dir}

	tar -zxf System.tar.gz -C ${D}/${dir}

	cp -rf ${GAMES_CD}/{Maps,Music,Sounds} ${D}/${dir}/

	insinto ${dir}
	doins icon.* README*

	dosym ${GAMES_PREFIX_OPT}/unreal-tournament/System/Engine.so ${dir}/System/Engine.so
	dosym ${GAMES_PREFIX_OPT}/unreal-tournament/System/Core.so ${dir}/System/Core.so

	dogamesbin ${FILESDIR}/unreal
	dosed "s:GENTOO_DIR:${GAMES_BINDIR}:" ${GAMES_BINDIR}/unreal

	prepgamesdirs
}
