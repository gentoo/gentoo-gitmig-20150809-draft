# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bglibs/bglibs-1.001.ebuild,v 1.1 2002/06/26 21:45:28 bangert Exp $

DESCRIPTION="Bruce Guenters library package"
HOMEPAGE="http://untroubled.org/bglibs/"
SLOT="0"
LICENSE="GPL-2"


DEPEND="virtual/glibc"
SRC_URI="http://untroubled.org/bglibs/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
	echo "${D}/usr/lib/bglibs" > conf-home
	echo "gcc ${CFLAGS}" > conf-cc
	emake || die
}

src_install () {
	dodir /usr/lib/bglibs
	./installer || die "install failed"
}
