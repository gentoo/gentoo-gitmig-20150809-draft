# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wlassistant/wlassistant-0.5.7.ebuild,v 1.1 2007/04/05 20:51:53 genstef Exp $

inherit kde

DESCRIPTION="A small application allowing you to scan for wireless networks and connect to them."
HOMEPAGE="http://sourceforge.net/projects/wlassistant"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND="dev-util/scons"
RDEPEND=">=net-wireless/wireless-tools-27-r1
	virtual/dhcpc"
need-kde 3.3

src_compile() {
	./configure || die "./configure failed"
	emake || die "emake failed"
}
