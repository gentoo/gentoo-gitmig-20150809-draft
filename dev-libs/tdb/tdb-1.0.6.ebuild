# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.14 2003/11/23 10:22:52 lanius Exp $

inherit gnuconfig

DESCRIPTION="A Trivial Database"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/tdb"

KEYWORDS="x86 sparc ~alpha ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	sys-libs/gdbm"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/tdb-1.0.6-gcc3.patch || die

	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README TODO
}
