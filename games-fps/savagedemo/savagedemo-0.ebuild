# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/savagedemo/savagedemo-0.ebuild,v 1.1 2003/10/12 03:48:38 vapier Exp $

inherit games eutils

DESCRIPTION="an intense first person combat mixed with RTS commanders"
HOMEPAGE="http://www.s2games.com/savage/"
SRC_URI="savagedemoinstaller-linux.sh"

LICENSE="SAVAGE"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="fetch nostrip"

DEPEND="virtual/x11
	virtual/opengl"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://www.s2games.com/savage/downloads.html"
	einfo "and place ${A} in ${DISTDIR}"
}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	cp -rf Savage/* linux/* ${D}/${dir}/
	insinto ${dir}/game
	doins linux/game/game_demo.so
	find ${D}/${dir} -type f -exec chmod a-x '{}' \;
	exeinto ${dir}
	doexe bin/x86/*

	dogamesbin ${FILESDIR}/${PN}
	dogamesbin ${FILESDIR}/${PN}-dedicated_server

	prepgamesdirs
}
