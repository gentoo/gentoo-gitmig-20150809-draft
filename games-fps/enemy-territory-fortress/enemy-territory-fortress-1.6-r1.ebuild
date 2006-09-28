# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.6-r1.ebuild,v 1.3 2006/09/28 18:52:06 wolf31o2 Exp $

MOD_DESC="Fortress"
MOD_NAME=etf
inherit eutils games games-etmod

HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://www.etf-center.com/files/etf_${PV}-english-2.run
	http://www.sonnensturm.net/download/etf_${PV}-english-2.run
	mirror://liflg/etf_${PV}-english-2.run"

RESTRICT="mirror strip"
LICENSE="as-is"

src_unpack() {
	unpack_makeself
	rm -rf setup.* bin
	tar xfz etf.tar.gz
	rm *.tar.gz search.sh
}
