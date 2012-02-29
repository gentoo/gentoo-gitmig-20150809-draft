# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2870-firmware/rt2870-firmware-29.ebuild,v 1.1 2012/02/29 14:25:15 tetromino Exp $

EAPI="4"

DESCRIPTION="Firmware for Ralink rt2870-based WiFi adapters (rt2800usb and rt2870sta modules)"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git
	http://www.ralinktech.com/en/04_support/support.php?sn=501"
# Files on Ralink's website are ancient; use linux-firmware data instead.
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="ralink-firmware"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( sys-fs/udev sys-apps/hotplug )"
DEPEND=""

src_install() {
	insinto /lib/firmware
	doins rt2870.bin rt3070.bin rt3071.bin
	# The license must be installed so that we can redistribute.
	# Otherwise binpkgs or CDs wouldn't have the license.
	dodoc LICENCE.ralink-firmware.txt WHENCE
}
