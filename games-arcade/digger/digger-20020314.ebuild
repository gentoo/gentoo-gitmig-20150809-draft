# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/digger/digger-20020314.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games

DESCRIPTION="Digger Remastered"
HOMEPAGE="http://www.digger.org/"
SRC_URI="http://www.digger.org/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="media-libs/libsdl"

src_compile() {
	emake -f Makefile.sdl || die
}

src_install() {
	dogamesbin digger
	dodoc digger.txt
	prepgamesdirs
}
