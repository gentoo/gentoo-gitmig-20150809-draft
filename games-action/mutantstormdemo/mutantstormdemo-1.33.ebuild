# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/mutantstormdemo/mutantstormdemo-1.33.ebuild,v 1.2 2004/02/20 06:13:56 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="shoot through crazy psychedelic 3D environments"
HOMEPAGE="http://www.pompom.org.uk/"
SRC_URI="ftp://ggdev-1.homelan.com/mutantstorm/MutantStormDemo_${PV/./_}.sh.bin"

LICENSE="POMPOM"
SLOT="0"
KEYWORDS="-* x86"

S=${WORKDIR}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	cp -r menu script styles ${D}/${dir}/

	exeinto ${dir}
	doexe bin/Linux/x86/*
	dosym ${dir}/mutantstormdemo ${GAMES_BINDIR}/mutantstormdemo

	insinto ${dir}
	doins README.txt buy_me mutant.xpm pompom readme.htm

	prepgamesdirs
}
