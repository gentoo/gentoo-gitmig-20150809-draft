# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_queue/libnetfilter_queue-0.0.15.ebuild,v 1.1 2007/08/19 12:08:58 cedk Exp $

inherit linux-info

DESCRIPTION="API to packets that have been queued by the kernel packet filter"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_queue/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libnfnetlink-0.0.30"
RDEPEND=${DEPEND}

CONFIG_CHECK="NETFILTER_NETLINK_QUEUE"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
