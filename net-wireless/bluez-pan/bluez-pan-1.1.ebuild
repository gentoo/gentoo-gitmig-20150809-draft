# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-pan/bluez-pan-1.1.ebuild,v 1.8 2004/07/18 23:48:44 aliz Exp $

DESCRIPTION="Bluetooth PAN profile implementation"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""
DEPEND=">=net-wireless/bluez-libs-2.2
	>=net-wireless/bluez-sdp-1.0"

src_install() {
	einstall || die
}
