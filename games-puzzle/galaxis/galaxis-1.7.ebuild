# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/galaxis/galaxis-1.7.ebuild,v 1.11 2010/10/16 19:55:52 tupone Exp $

EAPI=2
inherit games

DESCRIPTION="A UNIX-hosted, curses-based clone of the nifty little Macintosh freeware game Galaxis"
HOMEPAGE="http://www.catb.org/~esr/galaxis/"
SRC_URI="http://www.catb.org/~esr/galaxis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.3"
DEPEND="${RDEPEND}"

src_prepare() {
	# Modify CFLAGS
	sed -i \
		-e '/^CC/d' \
		-e '/^CFLAGS/s:-g:$(E_CFLAGS):' \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	emake E_CFLAGS="${LDFLAGS} ${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin galaxis || die "dogamesbin failed"
	doman galaxis.6
	dodoc README
	prepgamesdirs
}
