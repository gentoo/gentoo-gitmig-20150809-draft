# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_conntrack/libnetfilter_conntrack-0.0.50.ebuild,v 1.4 2007/04/17 18:07:09 cedk Exp $

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

	einfo "Checking for suitable kernel configuration options..."
	if ! linux_chkconfig_present "IP_NF_CONNTRACK_NETLINK" -a ! linux_chkconfig_present "NF_CT_NETLINK" ; then
		eerror "Could not find IP_NF_CONNTRACK_NETLINK "
		eerror "nor NF_CT_NETLINK in the kernel configuration"
		eerror "Please check to make sure at least one of the options are set correctly."
		die "Incorrect kernel configuration options"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
