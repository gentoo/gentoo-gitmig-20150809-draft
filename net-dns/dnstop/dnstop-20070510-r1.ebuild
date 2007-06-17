# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnstop/dnstop-20070510-r1.ebuild,v 1.1 2007/06/17 23:50:02 rajiv Exp $

inherit flag-o-matic

DESCRIPTION="Displays various tables of DNS traffic on your network."
HOMEPAGE="http://dnstop.measurement-factory.com/"
SRC_URI="http://dnstop.measurement-factory.com/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

IUSE="ipv6"
DEPEND="sys-libs/ncurses
	virtual/libpcap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-handle_ipv6.patch"
}

src_compile() {
	use ipv6 && append-flags -DUSE_IPV6

	sed -i "s:^CFLAGS=.*$:CFLAGS=${CFLAGS} -DUSE_PPP:" Makefile

	emake || die "emake failed."
}

src_install() {
	dobin dnstop
	doman dnstop.8
	dodoc LICENSE
	dodoc CHANGES
}
