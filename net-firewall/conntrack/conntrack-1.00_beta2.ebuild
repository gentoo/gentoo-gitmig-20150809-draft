# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/conntrack/conntrack-1.00_beta2.ebuild,v 1.5 2007/07/01 12:08:00 swegener Exp $

inherit linux-info

MY_P="${P/_}"

DESCRIPTION="view and manage the in-kernel connection tracking state table"
HOMEPAGE="http://www.netfilter.org/projects/conntrack/"
SRC_URI="http://www.netfilter.org/projects/conntrack/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc x86"
IUSE=""

DEPEND="net-libs/libnfnetlink
	net-libs/libnetfilter_conntrack"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 14 ; then
		die "${PN} requires at least 2.6.14 kernel version"
	fi

	#netfilter core team has changed some option names with kernel 2.6.20
	if kernel_is lt 2 6 20 ; then
		CONFIG_CHECK="IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="NF_CT_NETLINK"
	fi

	check_extra_config
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
