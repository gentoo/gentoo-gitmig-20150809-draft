# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.1.4.ebuild,v 1.2 2004/02/17 21:51:47 agriffis Exp $

IUSE=""

P=${PN}3-${PV}
DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ia64"

DEPEND=">=app-doc/doxygen-1.2.16"

src_compile() {
	econf --enable-release || die "econf failed"

	emake || die "emake failed"

	make doc || die "make doc failed"
}

src_install () {
	einstall || die "einstall failed"

	dohtml ${S}/doc/doxygen/html/*

	cd ${S}
	dodoc AUTHORS INSTALL README NEWS
}
