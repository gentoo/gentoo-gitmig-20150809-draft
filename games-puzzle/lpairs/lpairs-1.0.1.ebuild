# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lpairs/lpairs-1.0.1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

DESCRIPTION="Kids card/puzzle game"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LPairs"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	media-libs/libsdl"

src_compile() {
	egamesconf \
		--datadir=${GAMES_DATADIR_BASE} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
