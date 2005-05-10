# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpv6/dhcpv6-0.85-r1.ebuild,v 1.8 2005/05/10 10:22:23 dholm Exp $

inherit eutils

MY_P=${P/dhcpv6/dhcp6}
DESCRIPTION="Server and client for DHCPv6"
HOMEPAGE="http://sourceforge.net/projects/dhcpv6/"
SRC_URI="mirror://sourceforge/dhcpv6/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 hppa ~ppc"
IUSE="static"

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/patch-iaid-dhcp6-${PV}
	epatch ${FILESDIR}/${PN}-bison-fix.patch
}

src_compile() {
	econf || die
	use static && export LDFLAGS="${LDFLAGS} -static"
	emake || die
}

src_install() {
	einstall || die
	dodoc Install ReadMe docs/draft-ietf-dhc-dhcpv6-28.txt \
		docs/draft-ietf-dhc-dhcpv6-interop-{00,01}.txt \
		docs/draft-ietf-dhc-dhcpv6-opt-dnsconfig-03.txt \
		docs/draft-ietf-dhc-dhcpv6-opt-prefix-delegation-{02,03}.txt \
		dhcp6c.conf dhcp6s.conf

	dodir /var/lib/dhcpv6
	exeinto /etc/init.d
	newexe ${FILESDIR}/dhcp6s.rc dhcp6s
}

pkg_postinst() {
	einfo "Sample dhcp6c.conf and dhcp6s.conf files are in"
	einfo "/usr/share/doc/${P}/"
}
