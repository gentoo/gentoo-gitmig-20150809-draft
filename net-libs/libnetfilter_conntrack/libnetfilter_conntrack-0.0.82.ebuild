# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_conntrack/libnetfilter_conntrack-0.0.82.ebuild,v 1.4 2012/01/05 06:40:10 radhermit Exp $

inherit linux-info

DESCRIPTION="programming interface (API) to the in-kernel connection tracking state table"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_conntrack/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=net-libs/libnfnetlink-0.0.25"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 14 ; then
		die "${PN} requires at least 2.6.14 kernel version"
	fi

	#netfilter core team has changed some option names with kernel 2.6.20
	if kernel_is lt 2 6 20 ; then
		CONFIG_CHECK="~IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="~NF_CT_NETLINK"
	fi

	check_extra_config
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
