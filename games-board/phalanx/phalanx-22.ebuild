# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/phalanx/phalanx-22.ebuild,v 1.1 2007/05/29 21:40:14 tupone Exp $

inherit games

MY_PN="Phalanx"
MY_PV="XXII"
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="A chess engine suitable for beginner and intermediate players"
HOMEPAGE="http://phalanx.sourceforge.net"
SRC_URI="mirror://sourceforge/phalanx/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	# configure is not used in the project; confs are in Makefile,
	# and here we override them:
	local define="-DGNUFUN"
	for myvar in "PBOOK" "SBOOK" "LEARN" ; do
		define="${define} -D${myvar}_DIR=\"\\\"${GAMES_DATADIR}/${PN}\\\"\""
	done
	emake DEFINES="${define}" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin phalanx || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins pbook.phalanx sbook.phalanx learn.phalanx || die "doins failed"
	dodoc HISTORY README
	prepgamesdirs
}
