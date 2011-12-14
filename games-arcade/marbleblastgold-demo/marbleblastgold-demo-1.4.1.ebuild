# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/marbleblastgold-demo/marbleblastgold-demo-1.4.1.ebuild,v 1.7 2011/12/14 17:32:54 vapier Exp $

inherit eutils games

DESCRIPTION="race marbles through crazy stages"
HOMEPAGE="http://www.garagegames.com/pg/product/view.php?id=15"
SRC_URI="ftp://ggdev-1.homelan.com/marbleblastgold/MarbleBlastGoldDemo-${PV}.sh.bin"

LICENSE="MARBLEBLAST"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-libs/glibc"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir "${dir}" "${GAMES_BINDIR}"

	tar -zxf MarbleBlast.tar.gz -C "${D}/${dir}" || die "extracting MarbleBlast.tar.gz"

	exeinto "${dir}"
	doexe bin/Linux/x86/marbleblastgolddemo
	dosym "${dir}"/marbleblastgolddemo "${GAMES_BINDIR}"/marbleblastgold-demo

	insinto "${dir}"
	doins MarbleBlast.xpm

	dodoc README.txt

	prepgamesdirs
}
