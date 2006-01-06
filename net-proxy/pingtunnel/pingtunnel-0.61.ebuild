# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/pingtunnel/pingtunnel-0.61.ebuild,v 1.3 2006/01/06 11:39:14 mrness Exp $

DESCRIPTION="Tunnel TCP over ICMP"
HOMEPAGE="http://www.cs.uit.no/~daniels/PingTunnel"
SRC_URI="http://www.cs.uit.no/~daniels/PingTunnel/PingTunnel-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

DEPEND="net-libs/libpcap"

S="${WORKDIR}/PingTunnel"

src_unpack() {
	unpack ${A}

	#Don't force CC to gcc and use our CFLAGS
	sed -r -i \
		-e 's:^CC[ \t]+=:#&:' \
		-e 's:^(CFLAGS[ \t]+)=:\1+=:' \
		${S}/Makefile
}

src_install() {
	make prefix="${D}/usr" install || die "make install has failed"
	dodoc CHANGELOG README
	if use doc ; then
		dohtml web/*
	fi
}
