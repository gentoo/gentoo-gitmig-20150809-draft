# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/prism54-firmware/prism54-firmware-1.0.4.3.ebuild,v 1.6 2005/10/15 07:27:42 genstef Exp $

DESCRIPTION="Firmware for Intersil Prism GT / Prism Duette wireless chipsets"
HOMEPAGE="http://prism54.org/"
RESTRICT="nomirror"
SRC_URI="http://100h.org/wlan/linux/prismgt/${PV}.arm"
#http://prism54.org/~mcgrof/firmware/${PV}.arm old URL was removed, #109296
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

RDEPEND=">=sys-apps/hotplug-20040923"

src_unpack() { true; }

src_install() {
	insinto /lib/firmware/
	newins ${DISTDIR}/${PV}.arm isl3890
}
