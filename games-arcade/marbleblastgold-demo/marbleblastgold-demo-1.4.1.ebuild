# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/marbleblastgold-demo/marbleblastgold-demo-1.4.1.ebuild,v 1.6 2009/04/14 07:26:00 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="race marbles through crazy stages"
HOMEPAGE="http://www.garagegames.com/pg/product/view.php?id=15"
SRC_URI="ftp://ggdev-1.homelan.com/marbleblastgold/MarbleBlastGoldDemo-${PV}.sh.bin"

LICENSE="MARBLEBLAST"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
RESTRICT="strip"
PROPERTIES="interactive"
IUSE=""

RDEPEND="sys-libs/glibc"

GAMES_CHECK_LICENSE="yes"
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
