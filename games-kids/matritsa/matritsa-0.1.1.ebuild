# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/matritsa/matritsa-0.1.1.ebuild,v 1.1 2003/09/10 04:51:18 vapier Exp $

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
