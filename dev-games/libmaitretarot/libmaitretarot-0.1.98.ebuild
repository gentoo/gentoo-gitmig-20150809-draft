# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libmaitretarot/libmaitretarot-0.1.98.ebuild,v 1.4 2004/04/19 12:21:34 wolf31o2 Exp $

DESCRIPTION="backend library for the maitretarot games"
HOMEPAGE="http://www.nongnu.org/maitretarot/"
SRC_URI="http://savannah.nongnu.org/download/maitretarot/${PN}.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="=dev-libs/glib-2*
	dev-libs/libxml2"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
