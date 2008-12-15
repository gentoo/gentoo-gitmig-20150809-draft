# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_log/libnetfilter_log-0.0.15.ebuild,v 1.2 2008/12/15 23:11:42 pva Exp $

inherit linux-info

DESCRIPTION="interface to packets that have been logged by the kernel packet filter"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_log/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libnfnetlink-0.0.39"
RDEPEND="${DEPEND}"

CONFIG_CHECK="NETFILTER_NETLINK_LOG"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
