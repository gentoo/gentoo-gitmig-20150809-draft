# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/matritsa/matritsa-0.1.1.ebuild,v 1.2 2004/02/20 06:42:26 mr_bones_ Exp $

inherit games

DESCRIPTION="Kids card/puzzle game"
HOMEPAGE="http://imagic.weizmann.ac.il/~dov/freesw/matritsa.html"
SRC_URI="http://imagic.weizmann.ac.il/~dov/freesw/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/x11
	=x11-libs/gtk+-1*"

src_install() {
	egamesinstall || die
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
