# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/straw/straw-0.15.ebuild,v 1.1 2003/02/19 12:26:24 foser Exp $

DESCRIPTION="rss news aggregator"
HOMEPAGE="http://www.nongnu.org/straw/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/python
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.0.1
	>=dev-python/gnome-python-1.99.13
	>=dev-python/pygtk-1.99.13-r1
	>=dev-python/bsddb3-3.4.0
	>=dev-python/PyXML-0.8.1
	>=dev-python/egenix-mx-base-2"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:-d \$(BINDIR) \$(LIBDIR) \$(DATADIR):-d \$(BINDIR) \$(LIBDIR) \$(DATADIR) \$(APPLICATIONSDIR) \$(ICONDIR):" Makefile.orig > Makefile || die
}

src_compile() {
	emake || die
}

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc NEWS README TODO
}
