# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/bcs-demo/bcs-demo-1.3.ebuild,v 1.2 2006/04/18 13:18:45 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="design and build bridges and then stress test them with trains"
HOMEPAGE="http://garagegames.com/pg/product/view.php?id=17"
SRC_URI="ftp://ggdev-1.homelan.com/bcs/bcsdemo_v${PV/./_}.sh.bin"

LICENSE="BCS"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="media-libs/openal"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir} ${GAMES_BINDIR}

	tar -zxf bcsdemo.tar.gz -C ${Ddir} || die "extracting bcsdemo.tar.gz"

	exeinto ${dir}
	doexe bin/Linux/x86/rungame.sh || die
	dosym ${dir}/rungame.sh ${GAMES_BINDIR}/bcs-demo

	insinto ${dir}
	doins *.cfg || die
	dodoc readme* || die

	prepgamesdirs
}
