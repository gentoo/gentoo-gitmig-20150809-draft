# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/pvr-firmware/pvr-firmware-20070217-r1.ebuild,v 1.1 2008/01/25 16:54:00 cardoe Exp $

inherit eutils

DESCRIPTION="firmware for Hauppauge PVR and Conexant based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"

#Switched to recommended firmware by driver

SRC_URI="http://dl.ivtvdriver.org/ivtv/firmware/firmware-${PV}.tar.gz
	http://hauppauge.lightpath.net/software/install_cd/hauppauge_cd_3.4d1.zip"

RESTRICT="mirror"
SLOT="0"
LICENSE="Hauppauge-Firmware"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( >=sys-fs/udev-103 sys-apps/hotplug )"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv Drivers/Driver18/hcw18apu.rom v4l-cx23418-apu.fw
	mv Drivers/Driver18/hcw18enc.rom v4l-cx23418-cpu.fw
	mv Drivers/Driver18/hcw18mlC.rom v4l-cx23418-dig.fw
}

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
	doins *.mpg
}
