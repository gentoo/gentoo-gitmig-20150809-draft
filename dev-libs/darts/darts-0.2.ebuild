# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/darts/darts-0.2.ebuild,v 1.9 2004/09/27 02:31:31 usata Exp $

DESCRIPTION="A C++ template library that implements Double-Array"
HOMEPAGE="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/"
SRC_URI="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc ppc"
IUSE="zlib"
DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )"

src_compile() {
	econf `use_with zlib` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README || die
	dohtml doc/* || die
}
