# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libhash/libhash-1.0.2.ebuild,v 1.2 2004/07/17 09:35:17 dholm Exp $

inherit gcc

DESCRIPTION="a small hash library written in C"
HOMEPAGE="ftp://ftp.ugh.net.au/pub/unix/libhash/"
SRC_URI="ftp://ftp.ugh.net.au/pub/unix/libhash/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="doc"

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	rm -f Makefile
	$(gcc-getCC) ${CFLAGS} -fPIC -shared -o libhash.so hash.c || die ".so failed"
	$(gcc-getCC) ${CFLAGS} -c -o libhash.a hash.c || die ".a failed"
}

src_install() {
	insinto /usr/include
	doins hash.h || die "hash.h"
	dolib.so libhash.so || die "dolib.so"
	dolib.a libhash.a || die "dolib.a"
	doman *.3 || die "doman"
	use doc && dodoc tests/*.c
}
