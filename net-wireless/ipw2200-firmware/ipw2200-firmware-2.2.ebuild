# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200-firmware/ipw2200-firmware-2.2.ebuild,v 1.1 2005/01/18 10:41:18 brix Exp $

MY_P=${P/firmware/fw}
S=${WORKDIR}

DESCRIPTION="Firmware for the Intel PRO/Wireless 2200BG/2915ABG miniPCI adapter"

HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="ipw2200-fw"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=sys-apps/hotplug-20040923"

src_install() {
	insinto /lib/firmware
	doins *.fw

	newins LICENSE ipw-${PV}-LICENSE
}
