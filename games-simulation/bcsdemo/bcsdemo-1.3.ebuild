# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/bcsdemo/bcsdemo-1.3.ebuild,v 1.2 2004/02/20 07:33:25 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="design and build bridges and then stress test them with trains"
HOMEPAGE="http://garagegames.com/pg/product/view.php?id=17"
SRC_URI="ftp://ggdev-1.homelan.com/bcs/bcsdemo_v${PV/./_}.sh.bin"

LICENSE="BCS"
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

	tar -zxf bcsdemo.tar.gz -C ${D}/${dir} || die "extracting bcsdemo.tar.gz"

	exeinto ${dir}
	doexe bin/Linux/x86/rungame.sh
	dosym ${dir}/rungame.sh ${GAMES_BINDIR}/bcsdemo

	insinto ${dir}
	doins *.cfg

	dodoc readme*

	prepgamesdirs
}
