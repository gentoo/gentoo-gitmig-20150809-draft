# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/soccar/soccar-0.5.2.ebuild,v 1.3 2004/03/20 12:59:58 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Soccer with Cars"
HOMEPAGE="http://soccar.sourceforge.net/"
SRC_URI="mirror://sourceforge/soccar/${P}-src.tar.bz2
	mirror://sourceforge/soccar/${P}-data.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-util/jam
	dev-games/ogre
	dev-games/ode
	net-libs/enet"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-cfg-reloc.patch
	sed -i "s:GENTOO_CFGDIR:${GAMES_SYSCONFDIR}/${PN}:" src/{app,config}.cpp
	sed -i "s:-g -O2:${CXXFLAGS} `pkg-config OGRE --cflags`:" src/Jamfile
	sed -i 's:/local/:/:' plugins.cfg
}

src_compile() {
	jam || die
}

src_install() {
	insinto ${GAMES_SYSCONFDIR}/${PN}
	echo "FileSystem=${GAMES_DATADIR}/${PN}/" > resources.cfg
	doins resources.cfg plugins.cfg
	insinto ${GAMES_DATADIR}/${PN}
	doins data/*
	dogamesbin src/soccar
	prepgamesdirs
}
