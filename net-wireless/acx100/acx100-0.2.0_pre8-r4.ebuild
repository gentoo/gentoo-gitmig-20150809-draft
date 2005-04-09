# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/acx100/acx100-0.2.0_pre8-r4.ebuild,v 1.1 2005/04/09 07:23:53 genstef Exp $

inherit linux-mod

FIX_VERSION=51
FW_VERSION=307

DESCRIPTION="Driver for the ACX100 and ACX111 wireless chipset (CardBus, PCI,
USB driver disabled because it does not compile)"

HOMEPAGE="http://acx100.sourceforge.net/"
SRC_URI="http://lisas.de/~andi/${PN}/${P/_/}_plus_fixes_${FIX_VERSION}.tar.bz2
	http://www.houseofcraig.net/acx_firmware.tar.bz2"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcmcia"
RESTRICT="nomirror"

RDEPEND="pcmcia? ( >=sys-apps/hotplug-20040923 )
	net-wireless/wireless-tools"

S=${WORKDIR}/${P/_/}_plus_fixes_${FIX_VERSION}

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="acx_pci(net:${S}/src)"
	#acx_usb(net:${S}/src)
	CONFIG_CHECK="NET_RADIO FW_LOADER"
	#BUILD_PARAMS="KERNELVER=${KV_FULL} KERNELDIR=${KV_DIR} KERNEL_BUILD=${KV_DIR}"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}/src WLAN_HOSTIF=WLAN_PCI"
	BUILD_TARGETS="modules"
	MODULESD_ACX_PCI_ADDITIONS="options acx_pci firmware_dir=/lib/firmware"
}

src_compile() {
	sed -si "s:KERNEL_VER=\`uname -r\`:KERNEL_VER=${KV_FULL}:" Configure
	sed -si "s:KERNEL_BUILD=/lib/modules/\$KERNEL_VER/build:KERNEL_BUILD=${KV_DIR}:" Configure
	./Configure
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	dodoc README TODO ChangeLog doc/*

	insinto /lib/firmware
	doins ${WORKDIR}/usr/share/acx/*
}
