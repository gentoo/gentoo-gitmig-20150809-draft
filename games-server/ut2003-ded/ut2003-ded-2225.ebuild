# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/ut2003-ded/ut2003-ded-2225.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="Unreal Tournament 2003 Linux Dedicated Server"
HOMEPAGE="http://www.ut2003.com/"
SRC_URI="http://games.gci.net/pub/UT2003/ut2003-lnxded-${PV}.tar.bz2
	ftp://3dgamers.in-span.net/pub/3dgamers3/games/unrealtourn2/ut2003-lnxded-${PV}.tar.bz2"

LICENSE="ut2003"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"

S=${WORKDIR}/ut2003_dedicated

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	mv * ${D}/${dir}/
	prepgamesdirs
}

pkg_postinst() {
	ewarn "NOTE: To have your server authenticate properly, you"
	ewarn "      MUST visit the following site and request a key."
	ewarn "http://ut2003master.epicgames.com/ut2003server/cdkey.php"
	games_pkg_postinst
}
