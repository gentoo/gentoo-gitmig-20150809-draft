# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/dev-util/qtunit/qtunit-0.9.6.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp

DESCRIPTION="unit testing framework for c++"
SRC_URI="http://freesoftware.fsf.org/download/qtunit/${P}.tar.bz2"
HOMEPAGE="http://www.theleaf.be/projects/qtunit"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="=x11-libs/qt-3*"
	
export QTDIR="/usr/qt/3"
export PATH="$QTDIR/bin:$PATH"
export LD_LIBRARY_PATH="$QTDIR/lib:$LD_LIBRARY_PATH"
export QMAKESPEC="linux-g++"

src_compile() {
	qmake qtunit.pro || die
	make || die	# emake doesn't work
}

src_install() {
	insinto /usr

	dolib lib/libqtunit.so.1.0.0
	dosym /usr/lib/libqtunit.so.1.0.0 /usr/lib/libqtunit.so.1.0
	dosym /usr/lib/libqtunit.so.1.0 /usr/lib/libqtunit.so.1
	dosym /usr/lib/libqtunit.so.1 /usr/lib/libqtunit.so
	dobin bin/guitestrunner
	dobin bin/texttestrunner

	dodir /usr/include/qtunit
	find src -name "*.h" -exec cp '{}' ${D}/usr/include/qtunit ';'

	dodoc ChangeLog INSTALL

	dohtml -r html

	docinto plugins
	dodoc plugins/libexampletestmodule.so

	docinto samples/standalonerunner
	dodoc samples/standalonerunner/*.{cpp,h,pro}

	docinto samples/testmodule
	dodoc samples/testmodule/*.{cpp,h,pro}

	docinto samples/guitestrunner
	dodoc samples/guitestrunner/*.{cpp,pro}

	docinto samples/texttestrunner
	dodoc samples/texttestrunner/*.{cpp,pro}

	sed -e "s#<FILEPATH>#<FILEPATH>/usr/share/doc/${PF}/#" \
		-e "s#<SOURCEPATH>#<SOURCEPATH>/usr/share/doc/${PF}/#" \
		testproject.qpj > ${D}/usr/share/doc/${PF}/testproject.qpj
}
