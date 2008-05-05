# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnfnetlink/libnfnetlink-0.0.33.ebuild,v 1.4 2008/05/05 13:34:16 jer Exp $

inherit linux-info

DESCRIPTION="the low-level library for netfilter related kernel/userspace communication"
HOMEPAGE="http://www.netfilter.org/projects/libnfnetlink/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa ~ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

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
		ERROR_NF_CT_NETLINK="CONFIG_NF_CT_NETLINK:\t is not set when it should be. You can activate it in the Core Netfilter Configuration"
	fi

	check_extra_config
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
