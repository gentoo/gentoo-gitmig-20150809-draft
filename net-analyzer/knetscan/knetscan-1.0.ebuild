# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knetscan/knetscan-1.0.ebuild,v 1.5 2004/03/14 17:24:40 mr_bones_ Exp $

inherit kde
need-kde 3

IUSE=""
LICENSE="GPL-2"
DESCRIPTION="KDE frontend for nmap, ping, whois and traceroute"
SRC_URI="mirror://sourceforge/knetscan/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/knetscan"
KEYWORDS="x86 ~ppc"

newdepend ">=net-analyzer/nmap-2.54_beta36
	>=net-analyzer/traceroute-1.4_p12
	>=net-misc/whois-4.5.28-r1
	>=sys-apps/netkit-base-0.17-r5"
