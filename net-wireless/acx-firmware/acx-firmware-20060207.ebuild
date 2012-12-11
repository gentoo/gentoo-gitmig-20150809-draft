# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/acx-firmware/acx-firmware-20060207.ebuild,v 1.7 2012/12/11 17:07:28 axs Exp $

DESCRIPTION="Firmware for the ACX100 and ACX111 wireless chipsets"

RESTRICT="mirror"
HOMEPAGE="http://acx100.erley.org/acx_fw"
SRC_URI="http://www.kazer.org/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE=""
DEPEND="|| ( virtual/udev >=sys-apps/hotplug-20040923 )
	!<sys-fs/udev-096"
S=${WORKDIR}/fw

src_install() {
	insinto /lib/firmware
	doins acx100_1.0.9-USB/* acx100_1.9.8.b/* acx111_1.2.1.34/* acx111_2.3.1.31/*
}
