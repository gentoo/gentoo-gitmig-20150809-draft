# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.8.0.ebuild,v 1.1 2002/10/30 01:10:20 george Exp $


DESCRIPTION="CppUnit is the C++ port of the famous JUnit framework for unit testing."

HOMEPAGE="http://cppunit.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

DEPEND="app-doc/doxygen
	media-gfx/graphviz"

src_compile () {
	./configure --prefix=/usr || die
	emake || die
	#emake check || die
}

src_install () {
	# The libs
	insinto /usr
	dolib ${S}/src/cppunit/.libs/libcppunit-1.8.so.0.0.0 || die
	#the symlinks in /usr/lib should be local
	cd ${D}/usr/lib
	ln -sf libcppunit-1.8.so.0.0.0 libcppunit-1.8.so.0 || die
	ln -sf libcppunit-1.8.so.0.0.0 libcppunit.so || die
	cd ${S}
	dolib ${S}/src/cppunit/.libs/libcppunit.a || die

	# Main headers
	dodir /usr/include
	dodir /usr/include/cppunit
	find src -name "*.h" -exec cp '{}' ${D}/usr/include/cppunit ';'

	# The user interface headers. There's also a MFC header, but it's
	# not as if this is ever going to be used on a 'doze box. *grin*
	dodir /usr/include/cppunit/ui
	dodir /usr/include/cppunit/ui/qt
	find ${S}/src -name "*.h" -exec cp '{}' ${D}/usr/include/cppunit/ui/qt ';'
	dodir /usr/include/cppunit/ui/text
	find ${S}/src -name "*.h" -exec cp '{}' ${D}/usr/include/cppunit/ui/text ';'

	# And extension headers
	dodir /usr/include/cppunit/extensions
	find ${S}/src -name "*.h" -exec cp '{}' ${D}/usr/include/cppunit/extensions ';'

	# And now for the documentation
	docinto /usr
	dodoc ChangeLog INSTALL COPYING

	dodir /usr/share/doc/${P}
	#cp -a ${S}/doc/html ${D}/usr/share/doc/${P}
	dohtml doc/html

	# There's a two-question text FAQ as well, but it's included in the
	# html docs and IMO not worth repeating.

	# Now examples, first a 'game' example:
	dodir /usr/share/doc/${P}/examples/hierarchy
	cp -a ${S}/examples/hierarchy/*.cpp ${D}/usr/share/doc/${P}/examples/hierarchy
	cp -a ${S}/examples/hierarchy/*.h ${D}/usr/share/doc/${P}/examples/hierarchy
	#cp -a ${S}/examples/hierarchy/hierarchy ${D}/usr/share/doc/${P}/examples/hierarchy

	# Then the cppunittest 'example':
	dodir /usr/share/doc/${P}/examples/cppunittest
	cp -a ${S}/examples/cppunittest/*.cpp ${D}/usr/share/doc/${P}/examples/cppunittest
	cp -a ${S}/examples/cppunittest/*.h ${D}/usr/share/doc/${P}/examples/cppunittest
	#cp -a ${S}/examples/cppunittest/cppunittestmain ${D}/usr/share/doc/${P}/examples/cppunittest
 
}

