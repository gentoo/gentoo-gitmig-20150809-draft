# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/straw/straw-0.19.2.ebuild,v 1.1 2005/03/18 14:22:06 seemant Exp $

inherit python distutils

DESCRIPTION="RSS/RDF News Aggregator"
HOMEPAGE="http://www.nongnu.org/straw/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
RDEPEND=">=dev-lang/python-2.2.3-r3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.0.1
	>=dev-python/gnome-python-1.99.13
	>=dev-python/pygtk-1.99.13-r1
	>=dev-python/bsddb3-3.4.0
	>=dev-python/pyxml-0.8.1
	>=dev-python/egenix-mx-base-2
	=dev-python/adns-python-1.0.0"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	python_version
	sed -e "s:-d \$(BINDIR) \$(LIBDIR) \$(DATADIR):-d \$(BINDIR) \$(LIBDIR) \$(DATADIR) \$(APPLICATIONSDIR) \$(ICONDIR):" \
		-e "s:^\(PYTHON.*\)python2.2:\1python${PYVER}:" \
		-e "s:^\(LIBDIR.*\)python2.2\(.*\):\1python${PYVER}\2:" \
		-e "s:py\[co\]:py:" \
		-i ${S}/Makefile || die "sed failed"
	sed -e "s:/usr/bin/env python2.2:/usr/bin/env python${PYVER}:" \
		-i ${S}/src/straw
}

src_compile() {
	export LC_ALL="C"
	emake || die
}

src_install() {
	make PREFIX=${D}/usr install || die "install failed"
	dodoc NEWS README TODO
}

