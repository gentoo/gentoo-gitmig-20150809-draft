# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tint/tint-0.03b.ebuild,v 1.4 2008/06/26 17:36:40 nixnut Exp $

inherit eutils games

MY_P=${P/-/_}
DESCRIPTION="Tint Is Not Tetris, a ncurses based clone of the original Tetris(tm) game"
HOMEPAGE="http://oasis.frogfoot.net/code/tint/"
SRC_URI="http://oasis.frogfoot.net/code/tint/download/${PV}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.4-r1"

src_compile() {
	emake \
		STRIP=true \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		localstatedir="${GAMES_STATEDIR}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin tint || die "dogamesbin failed"
	doman tint.6
	dodoc CREDITS NOTES
	insopts -m 0664
	insinto "${GAMES_STATEDIR}"
	doins tint.scores || die "doins failed"
	prepgamesdirs
}
