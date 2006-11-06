# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/pvr-firmware/pvr-firmware-20060701-r1.ebuild,v 1.3 2006/11/06 18:13:07 kugelfang Exp $

inherit eutils

DESCRIPTION="firmware for Hauppauge PVR and Conexant based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"

#Switched to recommended firmware by driver

SRC_URI="http://dl.ivtvdriver.org/ivtv/firmware/firmware-${PV}.tar.gz"

RESTRICT="nomirror"
SLOT="0"
LICENSE="Conexant-firmware"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="sys-apps/hotplug"

S="${WORKDIR}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
	doins *.mpg
}
