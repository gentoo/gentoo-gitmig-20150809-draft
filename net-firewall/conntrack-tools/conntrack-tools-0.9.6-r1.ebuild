# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/conntrack-tools/conntrack-tools-0.9.6-r1.ebuild,v 1.4 2008/05/05 13:34:45 jer Exp $

inherit linux-info

DESCRIPTION="Connection tracking userspace tools"
HOMEPAGE="http://people.netfilter.org/pablo/conntrack-tools/"
SRC_URI="http://www.netfilter.org/projects/conntrack-tools/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa sparc x86"
IUSE=""

DEPEND=">=net-libs/libnfnetlink-0.0.33
	>=net-libs/libnetfilter_conntrack-0.0.89"
RDEPEND="${DEPEND}
	!net-firewall/conntrack"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e '/-Werror \\/d' {.,src,extensions}/Makefile.in
}

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 18 ; then
		die "${PN} requires at least 2.6.18 kernel version"
	fi

	#netfilter core team has changed some option names with kernel 2.6.20
	if kernel_is lt 2 6 20 ; then
		CONFIG_CHECK="IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="NF_CT_NETLINK"
	fi
	CONFIG_CHECK="${CONFIG_CHECK} NF_CONNTRACK NF_CONNTRACK_IPV4
		NETFILTER_NETLINK NF_CONNTRACK_EVENTS"

	check_extra_config
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/conntrackd.initd" conntrackd
	newconfd "${FILESDIR}/conntrackd.confd" conntrackd

	insinto /etc/conntrackd
	doins doc/stats/conntrackd.conf

	dodoc AUTHORS ChangeLog

	# Clean unnecessary .svn directories
	find doc -type d -name ".svn" -print0 | xargs -0 -n1 rm -R
	insinto /usr/share/doc/${PF}
	doins -r doc
}
