# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter-userspace/l7-filter-userspace-0.10.ebuild,v 1.2 2009/02/17 16:08:56 pva Exp $

inherit eutils

DESCRIPTION="Userspace utilities for layer 7 iptables QoS"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"
DEPEND="
		net-libs/libnetfilter_conntrack
		net-libs/libnetfilter_queue"
RDEPEND="net-misc/l7-protocols
		${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-order-in-fix.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TODO BUGS THANKS AUTHORS
}
