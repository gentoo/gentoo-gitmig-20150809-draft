# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ascii-invaders/ascii-invaders-0.1b.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="Space invaders clone, using ncurses library"
HOMEPAGE="http://www.ip9.org/munro/invaders/"
SRC_URI="http://www.ip9.org/munro/invaders/invaders${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/invaders

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/-lcurses/-lncurses/g' Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin ascii_invaders
	dodoc TODO
	prepgamesdirs
}
