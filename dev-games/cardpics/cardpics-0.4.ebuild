# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cardpics/cardpics-0.4.ebuild,v 1.6 2004/04/17 07:53:24 vapier Exp $

inherit games

DESCRIPTION="set of free cards sets"
HOMEPAGE="http://www.nongnu.org/cardpics/"
SRC_URI="http://savannah.gnu.org/download/cardpics/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
