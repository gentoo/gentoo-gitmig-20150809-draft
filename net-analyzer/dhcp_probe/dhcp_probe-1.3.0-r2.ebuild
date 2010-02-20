# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dhcp_probe/dhcp_probe-1.3.0-r2.ebuild,v 1.1 2010/02/20 16:31:57 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="dhcp_probe attempts to discover DHCP and BootP servers on a directly-attached Ethernet network"
HOMEPAGE="http://www.net.princeton.edu/software/dhcp_probe/"
SRC_URI="http://www.net.princeton.edu/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	net-libs/libpcap
	>=net-libs/libnet-1.1.2.1-r2
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}/*.patch
}

src_configure() {
	STRIP=true econf || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}"

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}

	dodoc \
		extras/dhcp_probe.cf.sample \
		NEWS \
		README \
		ChangeLog \
		AUTHORS \
		TODO \
		|| die "dodoc failed"
}
