# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-pan/bluez-pan-1.1_rc2.ebuild,v 1.3 2003/07/13 20:56:55 aliz Exp $

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Bluetooth PAN profile implementation"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=net-wireless/bluez-libs-2.2
		>=net-wireless/bluez-sdp-1.0"

src_install() {
	einstall || die
}
