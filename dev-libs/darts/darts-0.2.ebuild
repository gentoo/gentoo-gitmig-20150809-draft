# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/darts/darts-0.2.ebuild,v 1.13 2005/12/29 20:55:46 halcy0n Exp $

DESCRIPTION="A C++ template library that implements Double-Array"
HOMEPAGE="http://chasen.org/~taku/software/darts/"
SRC_URI="http://chasen.org/~taku/software/darts/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 sparc ppc ppc64"
IUSE="zlib"
DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )"

src_compile() {
	econf `use_with zlib` || die
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README || die
	dohtml doc/* || die
}

