# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wlassistant/wlassistant-0.5.0.ebuild,v 1.1 2005/07/14 12:54:11 genstef Exp $

inherit kde
need-kde 3.3

DESCRIPTION="A small application allowing you to scan for wireless networks and connect to them."
HOMEPAGE="http://sourceforge.net/projects/wlassistant"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
RDEPEND=">=net-wireless/wireless-tools-27-r1
	virtual/dhcpc"
