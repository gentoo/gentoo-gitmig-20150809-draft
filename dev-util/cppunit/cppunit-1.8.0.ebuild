# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.8.0.ebuild,v 1.7 2004/03/13 01:49:46 mr_bones_ Exp $

IUSE=""

DESCRIPTION="CppUnit is the C++ port of the famous JUnit framework for unit testing."
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

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
