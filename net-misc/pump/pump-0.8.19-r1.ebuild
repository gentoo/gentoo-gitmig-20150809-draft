# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.19-r1.ebuild,v 1.1 2004/03/09 00:06:53 seemant Exp $

DESCRIPTION="This is the DHCP/BOOTP client written by RedHat"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64"

DEPEND=">=dev-libs/popt-1.5"

PROVIDE="virtual/dhcpc"

src_compile() {
	make pump || die
}

src_install () {
	exeinto /sbin
	doexe pump

	insinto /etc
	doins ${FILESDIR}/pump.conf

	doman pump.8
	dodoc COPYING CREDITS
}
