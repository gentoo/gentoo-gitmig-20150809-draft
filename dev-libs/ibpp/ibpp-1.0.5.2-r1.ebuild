# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ibpp/ibpp-1.0.5.2-r1.ebuild,v 1.5 2002/08/14 11:52:27 murphy Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="IBPP, a C++ client API for firebird 1.0"
SRC_URI="mirror://sourceforge/ibpp/ibpp-1-0-5-2-src.zip"
HOMEPAGE="http://ibpp.sourceforge.net/"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-db/firebird-1.0"

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack ibpp-1-0-5-2-src.zip
	patch -p1 < ${FILESDIR}/ibpp-1.0.5.2.patch || die
	rm ibase.h iberror.h 
}

src_compile() {
	emake PLATFORM="linux" || die
}

src_install () {
	dodir /usr/include
	insinto /usr/include
	doins ibpp.h
	cd release/linux
	dolib.so libibpp.so libibpp_core.so libibpp_helper.so
	dolib.a libibpp.a libibpp_core.a libibpp_helper.a
}
