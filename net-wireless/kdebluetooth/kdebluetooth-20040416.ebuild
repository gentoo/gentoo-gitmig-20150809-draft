# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-20040416.ebuild,v 1.4 2004/07/03 14:01:18 centic Exp $

inherit kde
need-kde 3

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="http://members.xoom.virgilio.it/motaboy/kdebluetooth-0.0.${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
RESTRICT="nomirror"
IUSE=""
SLOT="0"

DEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2
	>=net-wireless/bluez-sdp-1"

S="${WORKDIR}/kdebluetooth-0.0.${PV}"

pkg_postinst() {
	einfo "This new version of kde-bluetooth provide a replacement for the"
	einfo "standard bluepin program called \"kbluepin\"!!! "
	einfo ""
	einfo "If you want to use it, you have to edit your \"/etc/bluetooth/hcid.conf\" "
	einfo "and change the line \"pin_helper oldbluepin;\" with \"pin_helper /usr/bin/kbluepin;\""
	einfo "Then restart hcid to make the change working"
}
