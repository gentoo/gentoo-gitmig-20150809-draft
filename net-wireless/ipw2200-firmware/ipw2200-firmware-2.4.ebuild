# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200-firmware/ipw2200-firmware-2.4.ebuild,v 1.2 2005/11/17 13:36:14 brix Exp $

MY_P=${P/firmware/fw}
S=${WORKDIR}

DESCRIPTION="Firmware for the Intel PRO/Wireless 2200BG/2915ABG miniPCI and 2225BG PCI adapters"

HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="http://www.bughost.org/firmware/${MY_P}.tgz"

LICENSE="ipw2200-fw"
SLOT="${PV}"
KEYWORDS="~amd64 x86"

IUSE=""
DEPEND=">=sys-apps/hotplug-20040923"

src_install() {
	insinto /lib/firmware
	doins *.fw

	newins LICENSE ipw-${PV}-LICENSE
}
