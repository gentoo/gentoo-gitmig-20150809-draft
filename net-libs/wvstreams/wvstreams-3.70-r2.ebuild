# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-3.70-r1.ebuild,v 1.1 2002/07/04 02:47:58 lostlogic Exp

S=${WORKDIR}/${P}
DESCRIPTION="A network programming library in C++"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://open.nit.ca/wvstreams"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Patching failed"
}

src_compile() {
	CFLAGS="${CFLAGS} -Wno-deprecated"
	make || die
}

src_install() {

	make \
		PREFIX=${D}/usr \
		install || die
}
