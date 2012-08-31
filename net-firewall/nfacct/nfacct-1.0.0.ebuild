# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/nfacct/nfacct-1.0.0.ebuild,v 1.1 2012/08/31 19:52:16 pinkbyte Exp $

EAPI=4

inherit linux-info

DESCRIPTION="Command line tool to create/retrieve/delete accounting objects in NetFilter"
HOMEPAGE="http://netfilter.org/projects/nfacct"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libmnl
	~net-libs/libnetfilter_acct-${PV}"
RDEPEND="${DEPEND}"

CONFIG_CHECK="NETFILTER_NETLINK_ACCT"
