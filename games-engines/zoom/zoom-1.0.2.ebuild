# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/zoom/zoom-1.0.2.ebuild,v 1.2 2005/08/24 04:33:33 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="A fast, clean, modern Z-code interpreter for X"
HOMEPAGE="http://www.logicalshift.co.uk/unix/zoom/"
SRC_URI="http://www.logicalshift.co.uk/unix/zoom/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="virtual/x11
	>=media-libs/t1lib-1.3.1
	>=media-libs/libpng-1.2.4"
DEPEND=">=sys-devel/bison-1.34
	dev-lang/perl"

src_compile () {
	filter-flags "-ffast-math"
	egamesconf || die
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	dohtml -r manual
	prepgamesdirs
}
