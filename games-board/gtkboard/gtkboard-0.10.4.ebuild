# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkboard/gtkboard-0.10.4.ebuild,v 1.2 2004/02/29 10:13:56 vapier Exp $

inherit games

DESCRIPTION="Board games system"
HOMEPAGE="http://gtkboard.sf.net/"
SRC_URI="mirror://sourceforge/gtkboard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2"

src_install() {
	egamesinstall || die

	dodoc AUTHORS ChangeLog TODO
	dohtml doc/index.html
	prepgamesdirs
}
