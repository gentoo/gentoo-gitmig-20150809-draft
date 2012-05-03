# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/pglinux/pglinux-2.1.3_p20120503.ebuild,v 1.1 2012/05/03 00:45:24 hasufell Exp $

EAPI=4

inherit linux-info

DESCRIPTION="Privacy oriented firewall application"
HOMEPAGE="https://sourceforge.net/projects/peerguardian/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="cron dbus logrotate networkmanager qt4 zlib"

COMMON_DEPEND="
	net-libs/libnetfilter_queue
	net-libs/libnfnetlink
	dbus? ( sys-apps/dbus )
	zlib? ( sys-libs/zlib )
	qt4? ( sys-auth/polkit-qt
		x11-libs/qt-core:4
		x11-libs/qt-dbus:4
		x11-libs/qt-gui:4 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	sys-devel/libtool:2"
RDEPEND="${COMMON_DEPEND}
	net-firewall/iptables
	cron? ( virtual/cron )
	logrotate? ( app-admin/logrotate )
	networkmanager? ( net-misc/networkmanager )"

REQUIRED_USE="qt4? ( dbus )"

CONFIG_CHECK="~NETFILTER_NETLINK
	~NETFILTER_NETLINK_QUEUE
	~NETFILTER_XTABLES
	~NETFILTER_XT_TARGET_NFQUEUE
	~NETFILTER_XT_MATCH_IPRANGE
	~NETFILTER_XT_MARK
	~NETFILTER_XT_MATCH_MULTIPORT
	~NETFILTER_XT_MATCH_STATE
	~NF_CONNTRACK
	~NF_CONNTRACK_IPV4
	~NF_DEFRAG_IPV4
	~IP_NF_FILTER
	~IP_NF_IPTABLES
	~IP_NF_TARGET_REJECT"

src_configure() {
	econf \
		$(use_enable cron) \
		$(use_enable dbus) \
		$(use_enable logrotate) \
		$(use_enable networkmanager) \
		$(use_enable zlib) \
		$(use_with qt4)
}
