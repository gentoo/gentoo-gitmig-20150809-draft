# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xfi-drivers/xfi-drivers-1.00.ebuild,v 1.5 2012/06/20 15:37:52 mr_bones_ Exp $

EAPI=4

inherit linux-mod

MY_PN=XFiDrv_Linux_Public_US
MY_P=${MY_PN}_${PV}

DESCRIPTION="Driver for the XFI-series Creative sound cards"
HOMEPAGE="http://www.creative.com/"
SRC_URI="http://files.creative.com/manualdn/Drivers/AVP/10792/0x0343D29A/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${MY_P}

MODULE_NAMES="ctxfi(sound:${S}:${S})"
CONFIG_CHECK="SND SOUND"

src_prepare() {

	BUILD_TARGETS="all"
	BUILD_PARAMS="$(use debug&&echo DEBUG=y)"

	sed -r \
		-e 's/KERNELDIR/KERNEL_DIR/g' \
		-e 's/CFLAGS/EXTRA_CFLAGS/' \
		-e 's:-g::g' \
		-e "s:/lib/modules/\`uname -r\`:/lib/modules/${KV_FULL}:g" \
		-e "/^KERNEL_DIR/s:=.*$:= ${KERNEL_DIR}:g" \
		-i Makefile || die
}
