# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfreecell/xfreecell-1.0.5b.ebuild,v 1.3 2004/04/14 20:06:18 mr_bones_ Exp $

inherit eutils games

S="${WORKDIR}/${PN}"
DESCRIPTION="A freecell game for X"
HOMEPAGE="http://www2.giganet.net/~nakayama/"
SRC_URI="http://www2.giganet.net/~nakayama/${P}.tgz
	http://www2.giganet.net/~nakayama/MSNumbers.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_install() {
	dogamesbin xfreecell || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins "${WORKDIR}/MSNumbers" || die "doins failed"
	dodoc CHANGES README mshuffle.txt
	doman xfreecell.6
	prepgamesdirs
}
