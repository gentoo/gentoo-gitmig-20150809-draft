# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.16 2004/04/18 16:26:01 aliz Exp $

inherit gnuconfig eutils

DESCRIPTION="A Trivial Database"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/tdb"

KEYWORDS="x86 sparc alpha ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	sys-libs/gdbm"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/tdb-1.0.6-gcc3.patch || die

	gnuconfig_update
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README TODO
}
