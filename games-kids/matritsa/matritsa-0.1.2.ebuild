# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/matritsa/matritsa-0.1.2.ebuild,v 1.6 2004/11/05 04:52:40 josejx Exp $

inherit games

DESCRIPTION="Kids card/puzzle game"
HOMEPAGE="http://imagic.weizmann.ac.il/~dov/freesw/matritsa.html"
SRC_URI="http://imagic.weizmann.ac.il/~dov/freesw/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/x11
	=x11-libs/gtk+-1*"

src_install() {
	egamesinstall || die
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
