# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.19-r1.ebuild,v 1.4 2004/11/02 20:15:44 vapier Exp $

DESCRIPTION="This is the DHCP/BOOTP client written by RedHat"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/popt-1.5"

PROVIDE="virtual/dhcpc"

src_compile() {
	make pump || die
}

src_install() {
	into /
	dosbin pump || die

	insinto /etc
	doins ${FILESDIR}/pump.conf

	doman pump.8
	dodoc CREDITS
}
