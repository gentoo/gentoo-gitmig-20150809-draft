# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcec/libcec-1.5.2.ebuild,v 1.1 2012/04/01 20:01:45 thev00d00 Exp $

EAPI=4

inherit autotools linux-info vcs-snapshot

DESCRIPTION="Library for communicating with the Pulse-Eight USB HDMI-CEC Adaptor"
HOMEPAGE="http://libcec.pulse-eight.com"
SRC_URI="http://github.com/Pulse-Eight/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/autoconf-2.13
	>=sys-devel/automake-1.11
	sys-devel/libtool
	"
RDEPEND=">=sys-fs/udev-151"

pkg_setup() {
	if linux_config_exists; then
		if ! linux_chkconfig_present USB_ACM; then
			ewarn "You should enable the USB_ACM support in your kernel."
			ewarn "Check the 'USB Modem (CDC ACM) support' under the"
			ewarn "'Device Drivers' and 'USB support' option. It is"
			ewarn "marked as CONFIG_USB_ACM in the config"
			die 'missing CONFIG_USB_ACM'
		fi
	fi
}

src_prepare() {
	eautoreconf
}
