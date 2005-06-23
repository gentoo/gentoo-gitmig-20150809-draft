# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.4.ebuild,v 1.1 2005/06/23 19:44:03 wolf31o2 Exp $

MOD_DESC="Fortress"
MOD_NAME=etf
inherit eutils games games-etmod

HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://www.playlinux.net/pub/files/native/etf_${PV}-english-2.run
	ftp://ftp.et-scene.de/mods/etf/etf_14/etf_${PV}-english-2.run"

RESTRICT="nomirror nostrip"
LICENSE="as-is"

src_unpack() {
	unpack_makeself
	rm -rf setup.* bin
	tar xfz etf.tar.gz
	rm *.tar.gz search.sh
}
