# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.19 2004/09/15 17:36:14 eradicator Exp $

inherit gnuconfig eutils

DESCRIPTION="A Trivial Database"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/tdb"

KEYWORDS="x86 sparc alpha ppc amd64"
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
