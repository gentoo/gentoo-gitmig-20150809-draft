# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knetscan/knetscan-1.0.ebuild,v 1.3 2003/02/13 13:42:11 vapier Exp $

inherit kde-base
need-kde 3

IUSE=""
LICENSE="GPL-2"
DESCRIPTION="KDE frontend for nmap, ping, whois and traceroute"
SRC_URI="mirror://sourceforge/knetscan/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/knetscan"
KEYWORDS="x86"

newdepend ">=net-analyzer/nmap-2.54_beta36
	>=net-analyzer/traceroute-1.4_p12
	>=net-misc/whois-4.5.28-r1
	>=sys-apps/netkit-base-0.17-r5"
