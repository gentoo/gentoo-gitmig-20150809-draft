# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# /space/gentoo/cvsroot/gentoo-x86/dev-util/qtunit/qtunit-0.9.6.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp

S=${WORKDIR}/${P}
DESCRIPTION="QtUnit is a unit testing framework for c++"
SRC_URI="http://freesoftware.fsf.org/download/qtunit/${P}.tar.bz2"
HOMEPAGE="http://www.theleaf.be/projects/qtunit"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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
	
	dodoc ChangeLog
	dodoc INSTALL
	dodoc COPYING

	dohtml -r html
	
	docinto plugins
	dodoc plugins/libexampletestmodule.so


	docinto samples/standalonerunner
	dodoc samples/standalonerunner/*.cpp
	dodoc samples/standalonerunner/*.h
	dodoc samples/standalonerunner/*.pro

	docinto samples/testmodule
	dodoc samples/testmodule/*.cpp
	dodoc samples/testmodule/*.h
	dodoc  samples/testmodule/*.pro

	docinto samples/guitestrunner
	dodoc samples/guitestrunner/*.cpp
	dodoc samples/guitestrunner/*.pro

	docinto samples/texttestrunner
	dodoc samples/texttestrunner/*.cpp
	dodoc samples/texttestrunner/*.pro
	
	sed -e "s#<FILEPATH>#<FILEPATH>/usr/share/doc/${PF}/#" \
		-e "s#<SOURCEPATH>#<SOURCEPATH>/usr/share/doc/${PF}/#" \
		testproject.qpj > ${D}/usr/share/doc/${PF}/testproject.qpj

}

