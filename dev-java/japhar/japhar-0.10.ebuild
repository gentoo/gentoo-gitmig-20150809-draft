# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/japhar/japhar-0.10.ebuild,v 1.7 2004/03/19 01:15:03 zx Exp $

DESCRIPTION="A Free Java Virtual Machine (JVM)"
SRC_URI="ftp://ftp.japhar.org/pub/hungry/japhar/source/${P}.tar.gz"
HOMEPAGE="http://www.japhar.org/"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc
		virtual/x11
		>=sys-libs/zlib-1.1.3
		>=dev-libs/nspr-4.1.2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
