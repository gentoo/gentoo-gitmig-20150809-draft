# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200-firmware/ipw2200-firmware-2.3.ebuild,v 1.1 2005/05/18 12:03:23 brix Exp $

MY_P=${P/firmware/fw}
S=${WORKDIR}

DESCRIPTION="Firmware for the Intel PRO/Wireless 2200BG/2915ABG miniPCI and 2225BG PCI adapters"

HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="ipw2200-fw"
SLOT="${PV}"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND=">=sys-apps/hotplug-20040923"

src_install() {
	insinto /lib/firmware
	doins *.fw

	newins LICENSE ipw-${PV}-LICENSE
}
