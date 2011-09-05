# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/pingtunnel/pingtunnel-0.72.ebuild,v 1.1 2011/09/05 20:08:46 radhermit Exp $

EAPI="4"

inherit toolchain-funcs

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
		-e '/^CFLAGS/s:=.*:+= -Wall -fno-strict-aliasing:' \
		-e '/^LDOPTS/s:$: $(LDFLAGS):' \
		Makefile
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake prefix="${D}/usr" install
	dodoc CHANGELOG README
	if use doc ; then
		dohtml web/*
	fi
}
