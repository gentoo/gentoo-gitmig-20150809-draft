# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/hlfl/hlfl-0.60.0.ebuild,v 1.4 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="High Level Firewall Language"
SRC_URI="ftp://ftp.hlfl.org/pub/hlfl/${P}.tar.gz"
HOMEPAGE="http://www.hlfl.org"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {

	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--datadir=/usr/share/doc/${P} \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	
	install -d ${D}/usr/bin
	install -d ${D}/usr/man/man1
	install -d ${D}/usr/share/doc/${P}
	install src/hlfl ${D}/usr/bin
	install doc/hlfl.1 ${D}/usr/man/man1
	install doc/services.hlfl ${D}/usr/share/doc/${P}

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS \
	TODO doc/RoadMap doc/sample_1.hlfl doc/sample_2.hlfl \
	doc/test.hlfl doc/syntax.txt
}
