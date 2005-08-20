# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/acx100/acx100-0.2.4.ebuild,v 1.2 2005/08/20 06:52:34 genstef Exp $

inherit linux-mod

DESCRIPTION="Driver for the ACX100 and ACX111 wireless chipset (CardBus, PCI, USB)"

HOMEPAGE="http://acx100.sourceforge.net/"
SRC_URI="http://acx100.erley.org/acx-20050811.tar.bz2
	http://acx100.erley.org/fw.tar.bz2"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcmcia"
RESTRICT="nomirror"

RDEPEND=">=sys-apps/hotplug-20040923
	net-wireless/wireless-tools"

S=${WORKDIR}

MODULE_NAMES="acx_pci(net:${S}) acx_usb(net:${S})"
CONFIG_CHECK="NET_RADIO FW_LOADER"
# KERNELVER=${KV_FULL} KERNELDIR=${KV_DIR} KERNEL_BUILD=${KV_DIR} 
#SUBDIRS=${S} WLAN_HOSTIF=WLAN_PCI"
BUILD_TARGETS="modules"
MODULESD_ACX_PCI_ADDITIONS=" " #needed to clear out previous setting which caused problems with new ver

#KERNEL_VER=KERNEL_VER=${KV_FULL}
#KERNEL_BUILD=/lib/modules/\$KERNEL_VER/build:KERNEL_BUILD=${KV_DIR}:
pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's:usr/share/acx:lib/firmware:' -i helper.c || die "Fixing firmware directory failed"
}

src_install() {
	linux-mod_src_install

	dodoc README doc/*

	insinto /lib/firmware
	doins fw/acx111_1.2.1.34/* fw/acx100_1.9.8.b/* fw/acx100_1.0.9-USB/*
}

pkg_postinst() {
	update_depmod
	update_modules
	update_moduledb
	einfo "Please run 'etc-update' and then 'update-modules' to complete install"
}
