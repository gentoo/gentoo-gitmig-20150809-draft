# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syncdir/syncdir-1.0.ebuild,v 1.7 2004/02/22 20:12:53 agriffis Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Provides an alternate implementation for open, link, rename, and unlink "
HOMEPAGE="http://untroubled.org/syncdir"
SRC_URI="http://untroubled.org/syncdir/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

RDEPEND="virtual/glibc"

src_compile() {
	emake || die "compile problem"
}

src_install () {
	dodir /usr
	dodir /usr/lib

	make prefix=${D}/usr install || die "install problem"

	dodoc COPYING testsync.c
}
