# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ascii-invaders/ascii-invaders-0.1b.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games

DESCRIPTION="Space invaders clone, using ncurses library"
HOMEPAGE="http://www.ip9.org/munro/invaders/index.html"
SRC_URI="http://www.ip9.org/munro/invaders/invaders${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="x86 alpha"
SLOT="0"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/invaders

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's/-lcurses/-lncurses/g' ${S}/Makefile || \
			die "sed Makefile failed"
}
src_install() {
	dogamesbin ascii_invaders
	dodoc TODO
	prepgamesdirs
}
