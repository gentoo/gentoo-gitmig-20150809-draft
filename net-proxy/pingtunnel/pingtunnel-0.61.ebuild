# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/pingtunnel/pingtunnel-0.61.ebuild,v 1.2 2005/07/17 18:49:33 dholm Exp $

DESCRIPTION="Tunnel TCP over ICMP"
HOMEPAGE="http://www.cs.uit.no/~daniels/PingTunnel"
SRC_URI="http://www.cs.uit.no/~daniels/PingTunnel/PingTunnel-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PingTunnel"

src_unpack() {
	unpack ${A}

	sed -r -i -e 's:^(CFLAGS|CC):#&:' ${S}/Makefile
}

src_install() {
	make prefix="${D}/usr" install || die "make install has failed"
	dodoc CHANGELOG README
}
