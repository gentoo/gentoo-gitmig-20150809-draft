# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tdb/tdb-1.0.6.ebuild,v 1.23 2006/12/13 23:37:44 masterdriverz Exp $

inherit libtool eutils

DESCRIPTION="A Trivial Database"
HOMEPAGE="http://sourceforge.net/projects/tdb"
SRC_URI="mirror://sourceforge/tdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="!net-fs/samba"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc3.patch
	epatch "${FILESDIR}"/${P}-no-gdbm.patch	#113824
	elibtoolize #117051
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README TODO
}
