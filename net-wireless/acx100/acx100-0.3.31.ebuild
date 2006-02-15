# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/acx100/acx100-0.3.31.ebuild,v 1.1 2006/02/15 21:30:41 genstef Exp $

inherit linux-mod

DESCRIPTION="Driver for the ACX100 and ACX111 wireless chipset (CardBus, PCI, USB)"

HOMEPAGE="http://acx100.sourceforge.net/"
SRC_URI="http://acx100.erley.org/acx-20060204.tar.bz2
	http://195.66.192.167/linux/acx_patches/fw.tar.bz2"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="nomirror"

RDEPEND=">=sys-apps/hotplug-20040923
	net-wireless/wireless-tools"

S=${WORKDIR}

MODULE_NAMES="acx(net:${S})"
CONFIG_CHECK="NET_RADIO FW_LOADER"
BUILD_TARGETS="modules"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S}"
}

src_unpack() {
	unpack acx-20060204.tar.bz2
	chmod ug+w . -R
	unpack fw.tar.bz2
	sed -i 's:usr/share/acx:lib/firmware:' common.c
}

src_install() {
	linux-mod_src_install

	dodoc README

	insinto /lib/firmware
	doins fw/acx100_1.0.9-USB/* fw/acx100_1.9.8.b/* fw/acx111_1.2.1.34/* fw/acx111_2.3.1.31/*
}
