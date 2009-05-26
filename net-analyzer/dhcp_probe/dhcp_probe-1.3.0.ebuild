# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dhcp_probe/dhcp_probe-1.3.0.ebuild,v 1.1 2009/05/26 00:00:55 jer Exp $

EAPI="2"

DESCRIPTION="dchp_probe attempts to discover DHCP and BootP servers on a directly-attached Ethernet network"
HOMEPAGE="http://www.net.princeton.edu/software/dhcp_probe/"
SRC_URI="http://www.net.princeton.edu/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	net-libs/libpcap
	>=net-libs/libnet-1.1.2.1-r2
	"
RDEPEND="${DEPEND}"

src_configure() {
	STRIP=true econf || die "econf failed"
}

src_install() {
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	dobin src/dhcp_probe "${FILESDIR}"/dhcp_probe_mail || die "dobin failed"
	dodoc \
		extras/dhcp_probe.cf.sample \
		NEWS \
		README \
		ChangeLog \
		AUTHORS \
		TODO \
		|| die "dodoc failed"
	doman \
		doc/dhcp_probe.8 \
		doc/dhcp_probe.cf.5 \
		|| die "doman failed"
}
