# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netdate/netdate-1.2.ebuild,v 1.2 2004/05/27 04:36:18 weeve Exp $

DESCRIPTION="A Utility to synchronize the time with ntp-servers"
SRC_URI="mirror://netdate-${PV}.tar.bz2"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="virtual/glibc"

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