# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/geki3-KXL/geki3-KXL-1.0.3.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

DESCRIPTION="2D length scroll shooting game"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"
HOMEPAGE="http://kxl.hn.org/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=dev-games/KXL-1.1.7"

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README
	prepgamesdirs
}
