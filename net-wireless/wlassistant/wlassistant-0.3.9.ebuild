# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wlassistant/wlassistant-0.3.9.ebuild,v 1.1 2005/05/17 10:41:15 genstef Exp $

inherit kde
need-kde 3.3

DESCRIPTION="A small application allowing you to scan for wireless networks and connect to them."
HOMEPAGE="http://sourceforge.net/projects/wlassistant"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
RDEPEND="net-wireless/wireless-tools
	virtual/dhcpc"

src_unpack() {
	kde_src_unpack
	sed -i "s:/sbin/iw:/usr/sbin/iw:" src/waconfig.kcfg
}
