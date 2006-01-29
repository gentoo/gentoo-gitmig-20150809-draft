# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfreecell/xfreecell-1.0.5b.ebuild,v 1.9 2006/01/29 21:28:01 joshuabaergen Exp $

inherit eutils games

S="${WORKDIR}/${PN}"
DESCRIPTION="A freecell game for X"
HOMEPAGE="http://www2.giganet.net/~nakayama/"
SRC_URI="http://www2.giganet.net/~nakayama/${P}.tgz
	http://www2.giganet.net/~nakayama/MSNumbers.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc64 ~ppc ~amd64"
IUSE=""

RDEPEND="|| ( x11-libs/libXext virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

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
