# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/darts/darts-0.2.ebuild,v 1.2 2004/01/06 04:06:35 brad_mssw Exp $

DESCRIPTION="A C++ template library that implements Double-Array"
HOMEPAGE="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/"
SRC_URI="http://cl.aist-nara.ac.jp/~taku-ku/software/darts/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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
