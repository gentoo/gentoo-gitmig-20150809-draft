# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vrb/vrb-0.3.0.ebuild,v 1.12 2004/07/02 04:56:57 eradicator Exp $

DESCRIPTION="library for a virtual ring buffer"
HOMEPAGE="http://phil.ipal.org/freeware/vrb/"
SRC_URI="http://phil.ipal.org/freeware/vrb/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"

DEPEND="virtual/libc"

src_compile() {
	sed -i "s/copts=\"-pipe -O2\"/copts=\"${CFLAGS}\"/g" Configure

	./Configure 						\
		--prefix=/usr || die "./Configure failed"

	make || die "emake failed"
}

src_install() {
	insinto /usr/include/libvrb/
	doins include/vrb.h

	dolib.so lib/libvrb.so.0.3.0
	dosym /usr/lib/libvrb.so.0.3.0 /usr/lib/libvrb.so.0.3
	dosym /usr/lib/libvrb.so.0.3.0 /usr/lib/libvrb.so.0
	dosym /usr/lib/libvrb.so.0.3.0 /usr/lib/libvrb.so

	dobin bin/iobuffer

	dodoc README
}
