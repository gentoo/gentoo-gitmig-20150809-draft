# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/thinktanksdemo/thinktanksdemo-1.1.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="tank combat game with lighthearted, fast paced pandemonium"
HOMEPAGE="http://garagegames.com/pg/product/view.php?id=12"
SRC_URI="ftp://ggdev-1.homelan.com/thinktanks/ThinkTanksDemo_v${PV}.sh.bin"

LICENSE="THINKTANKS"
SLOT="0"
KEYWORDS="-* x86"

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

	tar -zxf ThinkTanks.tar.gz -C ${D}/${dir} || die "extracting ThinkTanks.tar.gz"

	exeinto ${dir}
	doexe bin/Linux/x86/thinktanksdemo
	dosym ${dir}/thinktanksdemo ${GAMES_BINDIR}/thinktanksdemo

	insinto ${dir}
	doins icon.xpm

	dodoc ReadMe_Linux.txt

	prepgamesdirs
}
