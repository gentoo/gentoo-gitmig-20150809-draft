# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.5 2002/08/14 11:52:28 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tdb - Trivial Database"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/tdb"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}
