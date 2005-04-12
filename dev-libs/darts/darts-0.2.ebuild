# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/darts/darts-0.2.ebuild,v 1.12 2005/04/12 01:56:51 gustavoz Exp $

DESCRIPTION="A C++ template library that implements Double-Array"
HOMEPAGE="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/"
SRC_URI="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 sparc ppc ppc64"
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
