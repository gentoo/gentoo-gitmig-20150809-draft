# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.20 2004/10/26 20:43:57 agriffis Exp $

inherit gnuconfig eutils

DESCRIPTION="A Trivial Database"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/tdb"

KEYWORDS="x86 sparc alpha ppc amd64 ia64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
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
