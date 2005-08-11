# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/spacetripper-demo/spacetripper-demo-1.ebuild,v 1.4 2005/08/11 23:45:48 tester Exp $

inherit games eutils

MY_P="spacetripperdemo"
DESCRIPTION="hardcore arcade shoot-em-up"
HOMEPAGE="http://www.pompom.org.uk/"
SRC_URI="http://www.btinternet.com/%7Ebongpig/${MY_P}.sh"

LICENSE="POMPOM"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

S=${WORKDIR}

src_unpack() {
	check_license
	unpack_makeself
}

src_install() {
	dodir ${dir}

	cp -r preview run styles ${Ddir}

	exeinto ${dir}
	doexe bin/x86/*
	dosed "s:XYZZY:${dir}:" ${dir}/${MY_P}
	dosym ${dir}/${MY_P} ${GAMES_BINDIR}/${PN}

	insinto ${dir}
	doins README license.txt icon.xpm

	prepgamesdirs
}
