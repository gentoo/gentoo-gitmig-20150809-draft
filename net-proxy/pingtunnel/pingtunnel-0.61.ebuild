# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/pingtunnel/pingtunnel-0.61.ebuild,v 1.5 2006/07/21 05:28:12 vapier Exp $

DESCRIPTION="Tunnel TCP over ICMP"
HOMEPAGE="http://www.cs.uit.no/~daniels/PingTunnel"
SRC_URI="http://www.cs.uit.no/~daniels/PingTunnel/PingTunnel-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~x86"
IUSE="doc"

DEPEND="net-libs/libpcap"

S=${WORKDIR}/PingTunnel

src_unpack() {
	unpack ${A}
	sed -r -i \
		-e '/^CC[[:space:]]/d' \
		-e '/^CFLAGS/s:=.*:+= -Wall:' \
		-e '/^LDOPTS/s:$: $(LDFLAGS):' \
		"${S}"/Makefile
}

src_install() {
	make prefix="${D}/usr" install || die "make install has failed"
	dodoc CHANGELOG README
	if use doc ; then
		dohtml web/*
	fi
}
