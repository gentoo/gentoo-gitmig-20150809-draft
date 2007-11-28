# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/conntrack-tools/conntrack-tools-0.9.5.ebuild,v 1.2 2007/11/28 14:43:06 armin76 Exp $

inherit linux-info

DESCRIPTION="Connection tracking userspace tools"
HOMEPAGE="http://people.netfilter.org/pablo/conntrack-tools/"
SRC_URI="http://www.netfilter.org/projects/conntrack-tools/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libnfnetlink-0.0.25
	>=net-libs/libnetfilter_conntrack-0.0.81
	!net-firewall/conntrack"
RDEPEND="${DEPEND}"

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

	newinitd "${FILESDIR}/conntrackd.initd" conntrackd
	newconfd "${FILESDIR}/conntrackd.confd" conntrackd

	insinto /etc/conntrackd
	doins examples/stats/conntrackd.conf

	dodoc AUTHORS ChangeLog
	insinto /usr/share/doc/${PF}
	doins -r examples
}
