# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/pvr-firmware/pvr-firmware-20070217.ebuild,v 1.2 2007/07/02 15:22:13 peper Exp $

inherit eutils

DESCRIPTION="firmware for Hauppauge PVR and Conexant based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"

#Switched to recommended firmware by driver

SRC_URI="http://dl.ivtvdriver.org/ivtv/firmware/firmware-${PV}.tar.gz"

RESTRICT="mirror"
SLOT="0"
LICENSE="Hauppauge-Firmware"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="|| ( >=sys-fs/udev-103 sys-apps/hotplug )"

S="${WORKDIR}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
	doins *.mpg
}
