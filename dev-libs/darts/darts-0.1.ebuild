# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/darts/darts-0.1.ebuild,v 1.1 2003/06/20 16:41:55 yakina Exp $

DESCRIPTION="A C++ template library that implements Double-Array"
HOMEPAGE="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/"
SRC_URI="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE="zlib"
DEPEND="virtual/glibc
	zlib? ( sys-libs/zlib )"
S=${WORKDIR}/${P}

src_compile() {
	econf `use_with zlib` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README || die
	dohtml doc/* || die
}
