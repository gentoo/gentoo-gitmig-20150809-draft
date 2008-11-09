# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xfi-drivers/xfi-drivers-1.00.ebuild,v 1.1 2008/11/09 13:32:05 loki_val Exp $

inherit linux-mod

MY_PN=XFiDrv_Linux_Public_US
MY_P=${MY_PN}_${PV}

DESCRIPTION="Driver for the XFI-series Creative sound cards"
HOMEPAGE="http://www.creative.com/"
SRC_URI="http://files.creative.com/manualdn/Drivers/AVP/10792/0x0343D29A/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

MODULE_NAMES="ctxfi(sound:${S}:${S})"
BUILD_TARGETS="all"
BUILD_PARAMS="$(use debug&&echo DEBUG=y)"
CONFIG_CHECK="SND SND_DRIVERS SND_PCI SOUND"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -r -i	-e 's/KERNELDIR/KERNEL_DIR/g' \
			-e 's/CFLAGS/EXTRA_CFLAGS/' \
			Makefile
}
