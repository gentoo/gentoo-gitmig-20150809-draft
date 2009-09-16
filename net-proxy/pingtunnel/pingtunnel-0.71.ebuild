# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/pingtunnel/pingtunnel-0.71.ebuild,v 1.1 2009/09/16 21:16:36 mrness Exp $

EAPI="2"

DESCRIPTION="Tunnel TCP over ICMP"
HOMEPAGE="http://www.cs.uit.no/~daniels/PingTunnel"
SRC_URI="http://www.cs.uit.no/~daniels/PingTunnel/PingTunnel-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~x86"
IUSE="doc"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/PingTunnel

src_prepare() {
	sed -r -i \
		-e '/^CC[[:space:]]/d' \
		-e '/^CFLAGS/s:=.*:+= -Wall -fno-strict-aliasing:' \
		-e '/^LDOPTS/s:$: $(LDFLAGS):' \
		Makefile
}

src_install() {
	emake prefix="${D}/usr" install || die "emake install has failed"
	dodoc CHANGELOG README
	if use doc ; then
		dohtml web/*
	fi
}
