# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/marbleblastgolddemo/marbleblastgolddemo-1.4.1.ebuild,v 1.4 2004/06/18 20:56:04 jhuebel Exp $

inherit eutils games

DESCRIPTION="race marbles through crazy stages"
HOMEPAGE="http://garagegames.com/pg/product/view.php?id=15"
SRC_URI="ftp://ggdev-1.homelan.com/marbleblastgold/MarbleBlastGoldDemo-${PV}.sh.bin"

LICENSE="MARBLEBLAST"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

DEPEND=""

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

	tar -zxf MarbleBlast.tar.gz -C ${D}/${dir} || die "extracting MarbleBlast.tar.gz"

	exeinto ${dir}
	doexe bin/Linux/x86/marbleblastgolddemo
	dosym ${dir}/marbleblastgolddemo ${GAMES_BINDIR}/marbleblastgolddemo

	insinto ${dir}
	doins MarbleBlast.xpm

	dodoc README.txt

	prepgamesdirs
}
