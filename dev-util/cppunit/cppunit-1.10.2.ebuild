# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.10.2.ebuild,v 1.1 2004/07/30 23:26:03 george Exp $

IUSE=""

DESCRIPTION="CppUnit is the C++ port of the famous JUnit framework for unit testing."
HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

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
