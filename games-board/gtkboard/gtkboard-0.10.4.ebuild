# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkboard/gtkboard-0.10.4.ebuild,v 1.4 2004/07/14 14:30:20 agriffis Exp $

inherit games

DESCRIPTION="Board games system"
HOMEPAGE="http://gtkboard.sf.net/"
SRC_URI="mirror://sourceforge/gtkboard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2"

src_install() {
	egamesinstall || die

	dodoc AUTHORS ChangeLog TODO
	dohtml doc/index.html
	prepgamesdirs
}
