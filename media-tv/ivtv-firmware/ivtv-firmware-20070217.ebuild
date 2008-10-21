# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv-firmware/ivtv-firmware-20070217.ebuild,v 1.1 2008/10/21 18:10:11 cardoe Exp $

DESCRIPTION="firmware for Hauppauge PVR and Conexant based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"
SRC_URI="http://dl.ivtvdriver.org/ivtv/firmware/ivtv-firmware-${PV}.tar.gz"

RESTRICT="mirror"
SLOT="0"
LICENSE="Hauppauge-Firmware"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
	doins *.mpg
}
