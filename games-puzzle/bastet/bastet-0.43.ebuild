# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/bastet/bastet-0.43.ebuild,v 1.1 2010/12/03 07:55:11 tupone Exp $

EAPI=2
inherit toolchain-funcs eutils games

DESCRIPTION="a simple, evil, ncurses-based Tetris(R) clone"
HOMEPAGE="http://fph.altervista.org/prog/bastet.shtml"
SRC_URI="http://fph.altervista.org/prog/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	dev-libs/boost"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_compile() {
	emake CXX=$(tc-getCC) || die "make failed"
}

src_install() {
	dogamesbin bastet || die "dogamesbin failed"
	doman bastet.6
	dodoc AUTHORS NEWS README
	dodir "${GAMES_STATEDIR}"
	touch "${D}${GAMES_STATEDIR}/bastet.scores" || die "touch failed"
	fperms 664 "${GAMES_STATEDIR}/bastet.scores"
	prepgamesdirs
}
