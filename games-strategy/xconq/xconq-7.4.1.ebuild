# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xconq/xconq-7.4.1.ebuild,v 1.6 2004/12/01 04:15:29 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="a general strategy game system"
HOMEPAGE="http://sources.redhat.com/xconq/"
SRC_URI="ftp://sources.redhat.com/pub/xconq/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/x11
	dev-lang/tk
	dev-lang/tcl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc-3.4.patch
}

src_compile() {
	egamesconf \
		--enable-alternate-scoresdir=${GAMES_STATEDIR}/${PN}/scores \
		|| die
	emake \
		CFLAGS="${CFLAGS}" \
		datadir=${GAMES_DATADIR}/${PN} \
		|| die "emake failed"
}

src_install() {
	dodir ${GAMES_STATEDIR}/${PN} ${GAMES_DATADIR}/${PN}
	egamesinstall \
		scoresdir=${D}/${GAMES_STATEDIR}/${PN}/scores \
		datadir=${D}/${GAMES_DATADIR}/${PN} \
		|| die
	prepgamesdirs
}
