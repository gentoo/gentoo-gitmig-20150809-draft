# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-adminmod/halflife-adminmod-2.50.58.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

MY_P=${P/mod/}
DESCRIPTION="give people admin access (and a looooooot more)"
HOMEPAGE="http://www.adminmod.org/"
SRC_URI="mirror://sourceforge/halflifeadmin/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="games-server/halflife-metamod"
PDEPEND="games-server/halflife-modsetup"

S=${WORKDIR}/Adminmod

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix default values
	sed -i "s:addons:../addons:" config/{metamod,plugin}.ini
	sed -i "/^[^/]/s:^://:" config/Samples/{ips,users}.ini
	sed -i "/^[^/h]/s:^://:" config/Samples/models.ini
	epatch ${FILESDIR}/${PV}-adminmod.cfg
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/adminmod

	dodoc HISTORY NEWS README docs/*
	dohtml -r docs/html/*
	rm -rf HISTORY LICENSE NEWS README docs dlls/metamod_i386.so

	dodir ${dir}
	cp -rf ${S}/* ${FILESDIR}/modsetup ${D}/${dir}/
	dosym /usr/share/doc/${PF} ${dir}/docs

	prepgamesdirs
}
