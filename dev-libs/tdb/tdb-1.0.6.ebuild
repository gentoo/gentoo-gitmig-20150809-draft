# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer Jon Nelson <jnelson@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.1 2002/04/07 17:13:27 jnelson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tdb - Trivial Database"
SRC_URI="http://prdownloads.sourceforge.net/tdb/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/tdb"

src_compile() {
	./configure --prefix=/usr || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}
