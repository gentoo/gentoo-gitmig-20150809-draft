# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/cx18-firmware/cx18-firmware-20080628.ebuild,v 1.1 2008/10/21 18:17:42 cardoe Exp $

DESCRIPTION="firmware for Hauppauge PVR-1600 and Conexant 23418 based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"
SRC_URI="http://dl.ivtvdriver.org/ivtv/firmware/${P}.tar.gz"

RESTRICT="mirror"
SLOT="0"
LICENSE="Conexant-firmware"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
}
