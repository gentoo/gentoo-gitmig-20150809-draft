# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/dev-util/qtunit/qtunit-0.9.6.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp

S=${WORKDIR}/${P}
DESCRIPTION="QtUnit is a unit testing framework for c++"
SRC_URI="http://freesoftware.fsf.org/download/qtunit/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.theleaf.be/projects/qtunit"

DEPEND="=x11-libs/qt-3*"
	
export QTDIR="/usr/qt/3"
export PATH="$QTDIR/bin:$PATH"
export LD_LIBRARY_PATH="$QTDIR/lib:$LD_LIBRARY_PATH"
export QMAKESPEC="linux-g++"

src_compile() {

	qmake qtunit.pro || die
	make || die	# emake doesn't work

}

src_install () {

	insinto /usr
	dolib lib/libqtunit.so.1.0.0
	dosym /usr/lib/libqtunit.so.1.0.0 /usr/lib/libqtunit.so.1.0
	dosym /usr/lib/libqtunit.so.1.0 /usr/lib/libqtunit.so.1
	dosym /usr/lib/libqtunit.so.1 /usr/lib/libqtunit.so
	dobin bin/guitestrunner
	dobin bin/texttestrunner
	
	dodir /usr/include/qtunit
	find src -name "*.h" -exec cp '{}' ${D}/usr/include/qtunit ';'
	
	docinto /usr
	dodoc ChangeLog
	dodoc INSTALL
	dodoc COPYING

	dodir /usr/share/doc/${P}
	cp -a html ${D}/usr/share/doc/${P}
	
	dodir /usr/share/doc/${P}/plugins
	cp -a plugins/libexampletestmodule.so ${D}/usr/share/doc/${P}/plugins

	dodir /usr/share/doc/${P}/samples/standalonerunner
	dodir /usr/share/doc/${P}/samples/testmodule
	dodir /usr/share/doc/${P}/samples/guitestrunner
	dodir /usr/share/doc/${P}/samples/texttestrunner
	
	cp -a samples/standalonerunner/*.cpp ${D}/usr/share/doc/${P}/samples/standalonerunner
	cp -a samples/standalonerunner/*.h ${D}/usr/share/doc/${P}/samples/standalonerunner
	cp -a samples/standalonerunner/*.pro ${D}/usr/share/doc/${P}/samples/standalonerunner
	cp -a samples/testmodule/*.cpp ${D}/usr/share/doc/${P}/samples/testmodule
	cp -a samples/testmodule/*.h ${D}/usr/share/doc/${P}/samples/testmodule
	cp -a samples/testmodule/*.pro ${D}/usr/share/doc/${P}/samples/testmodule
	cp -a samples/guitestrunner/*.cpp ${D}/usr/share/doc/${P}/samples/guitestrunner
	cp -a samples/guitestrunner/*.pro ${D}/usr/share/doc/${P}/samples/guitestrunner
	cp -a samples/texttestrunner/*.cpp ${D}/usr/share/doc/${P}/samples/texttestrunner
	cp -a samples/texttestrunner/*.pro ${D}/usr/share/doc/${P}/samples/texttestrunner
	
	sed -e "s#<FILEPATH>#<FILEPATH>/usr/share/doc/${P}/#" \
		-e "s#<SOURCEPATH>#<SOURCEPATH>/usr/share/doc/${P}/#" \
		testproject.qpj > ${D}/usr/share/doc/${P}/testproject.qpj

}

