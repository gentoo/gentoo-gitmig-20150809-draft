# Copyright 2002 Johannes Findeisen <you@hanez.org>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vrb/vrb-0.3.0.ebuild,v 1.3 2002/08/14 11:52:28 murphy Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="The VRB library is a virtual ring buffer"
HOMEPAGE="http://phil.ipal.org/freeware/vrb/"
SRC_URI="http://phil.ipal.org/freeware/vrb/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	sed -e "s/copts=\"-pipe -O2\"/copts=\"${CFLAGS}\"/g" \
                < Configure > Configure.hacked
	cp Configure.hacked Configure
		
	./Configure 						\
		--prefix=/usr || die "./Configure failed"

	make || die "emake failed"
}

src_install () {

	insinto /usr/include/libvrb/
	doins include/vrb.h

	dolib.so lib/libvrb.so.0.3.0
	dosym /usr/lib/libvrb.so.0.3.0 /usr/lib/libvrb.so.0.3
	dosym /usr/lib/libvrb.so.0.3.0 /usr/lib/libvrb.so.0
	dosym /usr/lib/libvrb.so.0.3.0 /usr/lib/libvrb.so

	dobin bin/iobuffer

	dodoc INSTALL LICENSE README
}
