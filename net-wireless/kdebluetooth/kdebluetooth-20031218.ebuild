# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kdebluetooth/kdebluetooth-20031218.ebuild,v 1.1 2004/01/06 18:21:21 caleb Exp $

inherit kde
need-kde 3

DESCRIPTION="KDE Bluetooth Framework"
HOMEPAGE="http://kde-bluetooth.sourceforge.net/"
SRC_URI="http://members.xoom.virgilio.it/motaboy/kdebluetooth-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
RESTRICT="nomirror"

DEPEND=">=dev-libs/openobex-1
	>=net-wireless/bluez-libs-2
	>=net-wireless/bluez-sdp-1"

need-automake 1.6
need-autoconf 2.5

src_install() {
		kde_src_install
}
