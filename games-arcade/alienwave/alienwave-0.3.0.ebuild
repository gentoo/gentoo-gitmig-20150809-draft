# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/alienwave/alienwave-0.3.0.ebuild,v 1.9 2007/04/09 21:42:22 welp Exp $

inherit games

DESCRIPTION="An ncurses-based Xenon clone"
HOMEPAGE="http://www.cs.unibo.it/~pira/alienwave/aw.html"
SRC_URI="http://www.cs.unibo.it/~pira/alienwave/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s/-O2/${CFLAGS}/" \
		-e '/strip/d' \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin alienwave || die "dogamesbin failed"
	dodoc TO_DO README STORY
	prepgamesdirs
}
