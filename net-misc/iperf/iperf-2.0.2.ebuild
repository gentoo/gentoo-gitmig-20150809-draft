# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iperf/iperf-2.0.2.ebuild,v 1.1 2005/08/11 03:10:09 ka0ttic Exp $

DESCRIPTION="tool to measure IP bandwidth using UDP or TCP"
HOMEPAGE="http://dast.nlanr.net/Projects/Iperf"
SRC_URI="http://dast.nlanr.net/Projects/Iperf2.0/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="ipv6 threads debug"

DEPEND="virtual/libc"

src_compile() {
	econf \
		$(use_enable ipv6) \
		$(use_enable threads) \
		$(use_enable debug debuginfo) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc INSTALL README
	dohtml doc/*
	newinitd ${FILESDIR}/${PN}.initd ${PN}
	newconfd ${FILESDIR}/${PN}.confd ${PN}
}

pkg_postinst() {
	echo
	einfo "To run iperf in server mode, run:"
	einfo "  /etc/init.d/iperf start"
	echo
}
