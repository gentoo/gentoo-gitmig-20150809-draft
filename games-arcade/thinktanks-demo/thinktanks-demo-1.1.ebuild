# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/thinktanks-demo/thinktanks-demo-1.1.ebuild,v 1.2 2006/04/13 20:22:08 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="tank combat game with lighthearted, fast paced pandemonium"
HOMEPAGE="http://garagegames.com/pg/product/view.php?id=12"
SRC_URI="ftp://ggdev-1.homelan.com/thinktanks/ThinkTanksDemo_v${PV}.sh.bin"

LICENSE="THINKTANKS"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

DEPEND=""

GAMES_CHECK_LICENSE="yes"
S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	tar -zxf ThinkTanks.tar.gz -C ${D}/${dir} || die "extracting ThinkTanks.tar.gz"

	exeinto ${dir}
	doexe bin/Linux/x86/thinktanksdemo
	dosym ${dir}/thinktanksdemo ${GAMES_BINDIR}/thinktanks-demo

	insinto ${dir}
	doins icon.xpm

	dodoc ReadMe_Linux.txt

	prepgamesdirs
}
