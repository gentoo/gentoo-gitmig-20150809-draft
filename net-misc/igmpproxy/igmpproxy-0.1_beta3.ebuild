# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/igmpproxy/igmpproxy-0.1_beta3.ebuild,v 1.1 2009/05/03 20:05:13 idl0r Exp $

inherit linux-info

DESCRIPTION="Multicast Routing Daemon using only IGMP signalling (Internet Group Management Protocol)"
HOMEPAGE="http://sourceforge.net/projects/igmpproxy"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 Stanford"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="IP_MULTICAST IP_MROUTE"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/${PN}-init.d" ${PN} || die
	newconfd "${FILESDIR}/${PN}-conf.d" ${PN} || die
}
