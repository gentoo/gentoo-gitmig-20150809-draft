# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aget/aget-0.4.ebuild,v 1.9 2004/10/23 05:54:31 mr_bones_ Exp $

inherit eutils

IUSE=""
DEB_PATCH="${PN}_${PV}-4.diff"
DESCRIPTION="multithreaded HTTP download accelerator"
HOMEPAGE="http://www.enderunix.org/aget/"
SRC_URI="http://www.enderunix.org/${PN}/${P}.tar.gz
	mirror://debian/pool/main/a/${PN}/${DEB_PATCH}.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ppc64 ppc-macos"

DEPEND="virtual/libc"

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
