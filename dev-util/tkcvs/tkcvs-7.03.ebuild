# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tkcvs/tkcvs-7.03.ebuild,v 1.1 2002/09/27 10:05:40 seemant Exp $

MY_P=${PN}-${PV/./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="TkCVS"
SRC_URI="http://www.twobarleycorns.net/${MY_P}.tar.gz"
HOMEPAGE="http://www.twobarleycorns.net/tkcvs.html" 

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

RDEPEND=">=dev-lang/tk-8.1.1"

src_compile() {                           
	echo "It's tcl, you don't need to compile.  ;)"
}

src_install() {
	dodir /usr/lib /usr/bin /usr/lib/tkcvs/ /usr/lib/tkcvs/bitmaps
	
	./doinstall.tcl -nox ${D}/usr || die

	# Move man pages to FHS compliant locations
	dodir /usr/share/man/man1
	mv ${D}/usr/man/man1/* ${D}/usr/share/man/man1
	rm -rf ${D}/usr/man

	# Add docs...this is important
	dodoc CHANGELOG COPYING FAQ README.tkcvs README.windows

	docinto tkdiff
	dodoc tkdiff/PATCHES tkdiff/COPYING

	docinto tkcvs
	dodoc tkcvs/vendor.readme
}
