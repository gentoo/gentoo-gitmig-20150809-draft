# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_queue/libnetfilter_queue-1.0.0.ebuild,v 1.1 2011/05/23 10:28:41 jer Exp $

EAPI="3"

inherit autotools-utils linux-info

DESCRIPTION="API to packets that have been queued by the kernel packet filter"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_queue/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="static-libs"

COMMON_DEPEND=">=net-libs/libnfnetlink-0.0.41"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"
RDEPEND=${COMMON_DEPEND}

CONFIG_CHECK="~NETFILTER_NETLINK_QUEUE"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use static-libs || remove_libtool_files
}
