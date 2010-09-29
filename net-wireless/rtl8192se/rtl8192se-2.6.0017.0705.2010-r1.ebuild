# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl8192se/rtl8192se-2.6.0017.0705.2010-r1.ebuild,v 1.2 2010/09/29 20:25:27 chithanh Exp $

EAPI=3

inherit base linux-info linux-mod

MY_P="${PN}_linux_${PV}"

DESCRIPTION="RTL8191SE/8192SE wireless chipset driver"
HOMEPAGE="http:///www.realtek.com.tw/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	net-wireless/rtl8192se-firmware"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${PN}-include-semaphore.patch )
CONFIG_CHECK="CFG80211 MAC80211 ~WIRELESS_EXT"

MODULE_NAMES="r8192se_pci(${PN}::${S}/HAL/rtl8192)"
BUILD_TARGETS="all"

src_prepare() {
	base_src_prepare

	# fix build system, bug #338054 from sabayon
	ebegin "Fixing broken build system..."
	for rtl_makefile in "${S}/Makefile" "${S}/HAL/rtl8192/Makefile" "${S}/rtllib/Makefile"; do
		sed -i "${rtl_makefile}" -e "s:\`uname -r\`:${KV_FULL}:g" || die "Unable to patch Makefile"
		sed -i "${rtl_makefile}" -e "s:\$(shell uname -r):${KV_FULL}:g" || die "Unable to patch Makefile (2)"
		sed -i "${rtl_makefile}" -e "s:\$(shell uname -r|cut -d. -f1,2):${KV_MAJOR}.${KV_MINOR}:g" || die "Unable to patch Makefile (3)"
		sed -i "${rtl_makefile}" -e "s:\$(shell uname -r | cut -d. -f1,2,3,4):${KV_FULL}:g" || die "Unable to patch Makefile (4)"
		# useless... moblin stuff
		sed -i "${rtl_makefile}" -e "s:\$(shell uname -r | cut -d. -f6 | cut -d- -f1):${KV_LOCAL}:g" || die "Unable to patch Makefile (5)"
		# do not run depmod -a
		sed -i "${rtl_makefile}" -e 's:/sbin/depmod -a ${shell uname -r}::g' || die "Unable to patch Makefile (6)"
	done
	eend $?
}
