# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-0.0.20040715.ebuild,v 1.1 2004/08/01 13:13:05 carlo Exp $

inherit kde

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="http://www.webalice.it/simone.gotti/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.7"
RDEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2.7"
need-kde 3

pkg_postinst() {
	einfo "This new version of kde-bluetooth provide a replacement for the"
	einfo "standard bluepin program called \"kbluepin\"!!! "
	einfo ""
	einfo "If you want to use it, you have to edit your \"/etc/bluetooth/hcid.conf\" "
	einfo "and change the line \"pin_helper oldbluepin;\" with \"pin_helper /usr/bin/kbluepin;\""
	einfo "Then restart hcid to make the change working."
}
