# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl8192se/rtl8192se-2.6.0017.0705.2010.ebuild,v 1.1 2010/09/07 19:15:03 chithanh Exp $

EAPI=3

inherit linux-info linux-mod

MY_P="${PN}_linux_${PV}"

DESCRIPTION="RTL8191SE/8192SE wireless chipset driver"
HOMEPAGE="http:///www.realtek.com.tw/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="CFG80211 MAC80211"

MODULE_NAMES="r8192se_pci(kernel/drivers/${CATEGORY/-//}/${PN}::${S}/HAL/rtl8192)"
BUILD_TARGETS="all"
