# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.2.ebuild,v 1.1 2005/02/23 21:35:06 wolf31o2 Exp $

MOD_DESC="Fortress"
MOD_NAME=etf
inherit eutils games games-etmod

HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://www.fz.se/filarkiv/download.php?file=spel/rtcw/EnemyTerritory/mods/etf/etf_${PV}-english.run
	http://files.fraghappy.com/etf/etf_${PV}-english.run
	http://www.fz.se/filarkiv/download_mirror1.php?file=spel/rtcw/EnemyTerritory/mods/etf/etf_${PV}-english.run"

RESTRICT="nostrip"
LICENSE="as-is"

src_unpack() {
	unpack_makeself
	rm -rf setup.* bin
	tar xfz etf12.tar.gz
	rm *.tar.gz search.sh
}
