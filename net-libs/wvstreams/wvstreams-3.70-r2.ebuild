# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-3.70-r2.ebuild,v 1.11 2003/07/18 22:04:42 tester Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A network programming library in C++"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://open.nit.ca/wvstreams"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Patching failed"
	if [ "${ARCH}" = "alpha" ]; then
        sed "s:CXXOPTS += :CXXOPTS += -fPIC :" <Makefile >Makefile.sed
        mv Makefile.sed Makefile
    fi
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
