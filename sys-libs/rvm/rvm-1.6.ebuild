# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/rvm/rvm-1.6.ebuild,v 1.2 2002/07/23 22:20:41 lostlogic Exp $

DESCRIPTION="Recoverable Virtual Memory (used by Coda)"

# Appearantly maintained by the Coda people
HOMEPAGE="http://www.coda.cs.cmu.edu"

LICENSE="LGPL-2.1"

SLOT=1

# partly based on the deps suggested by Mandrake's RPM
DEPEND="virtual/glibc
	>=sys-libs/lwp-1.9"

RDEPEND=${DEPEND}

SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/rvm/src/${P}.tar.gz"

S=${WORKDIR}/${P}
KEYWORDS="x86"

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
