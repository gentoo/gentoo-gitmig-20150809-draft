# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aget/aget-0.4.ebuild,v 1.2 2004/03/28 12:07:16 dholm Exp $

inherit eutils

DEB_PATCH="${PN}_${PV}-4.diff"
DESCRIPTION="multithreaded HTTP download accelerator"
HOMEPAGE="http://www.enderunix.org/aget/"
SRC_URI="http://www.enderunix.org/${PN}/${P}.tar.gz
	mirror://debian/pool/main/a/${PN}/${DEB_PATCH}.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${DEB_PATCH}
	sed -i "/^CFLAGS/s:-g:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin aget || die
	dodoc AUTHORS ChangeLog README* THANKS TODO
	doman debian/aget.1
}
