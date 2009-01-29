# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/alienwave/alienwave-0.3.0.ebuild,v 1.10 2009/01/29 01:41:41 mr_bones_ Exp $

EAPI=2
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

src_prepare() {
	sed -i \
		-e "s/-O2/${CFLAGS}/" \
		-e '/strip/d' \
		-e '/^CC/d' \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin alienwave || die "dogamesbin failed"
	dodoc TO_DO README STORY
	prepgamesdirs
}
