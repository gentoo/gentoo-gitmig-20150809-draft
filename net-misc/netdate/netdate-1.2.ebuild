# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netdate/netdate-1.2.ebuild,v 1.4 2004/07/01 21:31:18 squinky86 Exp $

DESCRIPTION="A Utility to synchronize the time with ntp-servers"
SRC_URI="mirror://netdate-${PV}.tar.bz2"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	cd ${WORKDIR}/netdate
	emake || die "make failed"
}

src_install() {
	cd ${WORKDIR}/netdate
	dobin netdate
	doman netdate.8
	dodoc README COPYRIGHT
}