# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/mutantstorm-demo/mutantstorm-demo-1.33.ebuild,v 1.3 2005/06/29 13:16:56 wolf31o2 Exp $

inherit games eutils

DESCRIPTION="shoot through crazy psychedelic 3D environments"
HOMEPAGE="http://www.pompom.org.uk/"
SRC_URI="ftp://ggdev-1.homelan.com/mutantstorm/MutantStormDemo_${PV/./_}.sh.bin"

LICENSE="POMPOM"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

S=${WORKDIR}

RDEPEND="virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl )"

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
	dosym ${dir}/mutantstormdemo ${GAMES_BINDIR}/mutantstorm-demo

	insinto ${dir}
	doins README.txt buy_me mutant.xpm pompom readme.htm

	prepgamesdirs
}
