# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/galib/galib-2.4.5.ebuild,v 1.2 2003/11/21 07:07:42 phosphan Exp $

DESCRIPTION="library for using genetic algorithms in C++ programs"

HOMEPAGE="http://lancet.mit.edu/ga/"
SRC_URI="ftp://lancet.mit.edu/pub/ga/galib245.tar.gz"
LICENSE="GAlib"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=sys-apps/sed-4"

S=${WORKDIR}/galib245

src_compile() {
	make CXXFLAGS="${CXXFLAGS}" || die "make failed"
}

src_install() {
	dodir /usr/lib /usr/include
	make LIB_DEST_DIR=${D}/usr/lib/ HDR_DEST_DIR=${D}/usr/include/ install || die
	dohtml -r doc/*
	dodoc RELEASE-NOTES README
	cp -r examples ${D}/usr/share/doc/${PF}/
}
