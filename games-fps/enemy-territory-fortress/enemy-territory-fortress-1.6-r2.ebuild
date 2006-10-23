# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.6-r2.ebuild,v 1.2 2006/10/23 18:45:22 wolf31o2 Exp $

MOD_DESC="a class-based teamplay modification"
MOD_NAME="Fortress"
MOD_TBZ2="etf cfgnormal"
MOD_ICON="etf.xpm"
MOD_DIR="etf"
GAME="enemy-territory"

inherit eutils games games-mods

HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://www.etf-center.com/files/etf_${PV}-english-2.run
	http://www.playlinux.net/files/native/etf_${PV}-english-2.run
	http://liflg.httpdnet.com/files/native/etf_${PV}-english-2.run
	http://www.sonnensturm.net/download/etf_${PV}-english-2.run"

RDEPEND="games-fps/${GAME}"

QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/${GAME}/etf/omnibot_etf.so"

KEYWORDS="-* ~amd64 ~x86"

src_unpack() {
	# This is a prime example of how we should do our src_unpack for a mod that
	# has files that we don't want.
	games-mods_src_unpack
	rm -rf cfghi.tar.gz cfglow.tar.gz cfgxtrahi.tar.gz enemy-territory.xml \
		LICENSE search.sh bin
	cd "${S}"
	find . -type f -print0 | xargs -0 chmod a-x
}
