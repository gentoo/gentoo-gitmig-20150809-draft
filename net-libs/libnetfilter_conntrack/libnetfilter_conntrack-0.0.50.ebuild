# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_conntrack/libnetfilter_conntrack-0.0.50.ebuild,v 1.3 2007/04/15 10:20:52 dragonheart Exp $

inherit linux-info

DESCRIPTION="programming interface (API) to the in-kernel connection tracking state table"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_conntrack/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/libnfnetlink-0.0.25"
RDEPEND=${DEPEND}

CONFIG_CHECK="IP_NF_CONNTRACK_NETLINK"

pkg_setup() {
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
	if kernel_is le 2 6 19; then
		CONFIG_CHECK="IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="NF_CT_NETLINK"
	fi
	linux-info_pkg_setup
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
