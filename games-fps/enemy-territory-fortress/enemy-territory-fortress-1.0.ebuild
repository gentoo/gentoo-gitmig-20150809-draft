# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.0.ebuild,v 1.1 2005/01/16 00:39:48 vapier Exp $

MOD_DESC="Fortress"
MOD_NAME=etf
inherit eutils games games-etmod

MY_PV=${PV//.}
HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://media.muchosucko.com/etf/etf${MY_PV}.x86.run
	ftp://ftp.games.skynet.be/pub/wolfenstein/etf/etf${MY_PV}.x86.run
	http://camelot.snt.utwente.nl/etf/etf${MY_PV}.x86.run
	http://www.lleyad.com/etf${MY_PV}.x86.run
	ftp://ftp.edome.net/online/clientit/etf${MY_PV}.x86.run"

LICENSE="as-is"

src_unpack() {
	unpack_makeself

	# build install tree from setup.data/setup.xml
	rm -r bin setup.{sh,data}
	mkdir video
	mv etintro.roq video/

	for d in cfg* ; do
		mv ${d}/etconfig.cfg etconfig-${d}.cfg
		rmdir ${d}
	done
}
