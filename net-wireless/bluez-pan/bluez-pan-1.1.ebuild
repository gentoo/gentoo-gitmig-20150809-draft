# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-pan/bluez-pan-1.1.ebuild,v 1.2 2003/05/09 16:14:53 latexer Exp $

DESCRIPTION="Bluetooth PAN profile implementation"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${P}"
KEYWORDS="x86"
IUSE=""
DEPEND=">=net-wireless/bluez-libs-2.2
		>=net-wireless/bluez-sdp-1.0"

src_install() {
	einstall || die
}
