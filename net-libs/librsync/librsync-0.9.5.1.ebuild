# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.5.1.ebuild,v 1.2 2004/06/11 08:41:02 dholm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Flexible remote checksum-based differencing"
SRC_URI="http://rdiff-backup.stanford.edu/${P}.tar.gz"
HOMEPAGE="http://librsync.sf.net/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install  || die

	dodoc COPYING NEWS INSTALL AUTHORS THANKS README TODO
}
