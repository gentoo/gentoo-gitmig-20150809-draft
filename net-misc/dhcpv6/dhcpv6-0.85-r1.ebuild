# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpv6/dhcpv6-0.85-r1.ebuild,v 1.4 2003/11/27 21:05:19 mr_bones_ Exp $

MY_P=${P/dhcpv6/dhcp6}
DESCRIPTION="Server and client for DHCPv6"
HOMEPAGE="http://sourceforge.net/projects/dhcpv6/"
SRC_URI="mirror://sourceforge/dhcpv6/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="static"

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/patch-iaid-dhcp6-${PV}
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
