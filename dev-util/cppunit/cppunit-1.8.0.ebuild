# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.8.0.ebuild,v 1.10 2005/03/14 13:42:57 caleb Exp $

IUSE=""

DESCRIPTION="CppUnit is the C++ port of the famous JUnit framework for unit testing."
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"

DEPEND="app-doc/doxygen
	media-gfx/graphviz"

src_compile() {
	econf || die "./configure failed"
	emake || die
	#make check || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING NEWS README THANKS TODO
	# the package automatically puts its docs into /usr/share/cppunit
	# move them to the standard location and clean up
	mv ${D}/usr/share/cppunit/html ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/share/cppunit
}
