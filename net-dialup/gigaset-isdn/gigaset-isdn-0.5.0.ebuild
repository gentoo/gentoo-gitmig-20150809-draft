# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gigaset-isdn/gigaset-isdn-0.5.0.ebuild,v 1.3 2006/03/12 12:09:07 mrness Exp $

inherit linux-mod


DESCRIPTION="Kernel driver for Gigaset 307x/417x/SX353/USB Adapter DECT/M105/M101 and compatible ISDN adapters"
HOMEPAGE="http://gigaset307x.sourceforge.net/"
SRC_URI="mirror://sourceforge/gigaset307x/gigaset-driver-${PV}.tar.bz2
		mirror://sourceforge/gigaset307x/gigaset-frontend-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/linux-sources"

MY_DRIVER_S="${WORKDIR}/gigaset-driver-${PV}"
MY_FRONTEND_S="${WORKDIR}/gigaset-frontend-${PV}"
S="${MY_FRONTEND_S}"

MODULE_NAMES="gigaset(drivers/isdn:${MY_DRIVER_S}/gigaset) bas_gigaset(drivers/isdn:${MY_DRIVER_S}/gigaset)
	ser_gigaset(drivers/isdn:${MY_DRIVER_S}/gigaset) usb_gigaset(drivers/isdn:${MY_DRIVER_S}/gigaset)"
BUILD_TARGETS="all"
CONFIG_CHECK="ISDN_I4L"
ISDN_I4L_ERROR="This driver requires that your kernel is compiled with support for ISDN4Linux (I4L)"

src_unpack() {
	unpack ${A}

	# Fix broken makefile
	convert_to_m "${WORKDIR}/gigaset-driver-${PV}/gigaset/Makefile.26.in"

	# Fix includes
	sed -i -e "s:^INCLUDEDIRS +=:INCLUDEDIRS += \"-I${WORKDIR}/gigaset-driver-${PV}/include\":" \
		"${WORKDIR}/gigaset-frontend-${PV}/lib/Makefile"
}


src_compile() {
	cd "${MY_DRIVER_S}"
	./configure
	linux-mod_src_compile

	cd "${MY_FRONTEND_S}"
	./configure --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install () {
	linux-mod_src_install
	cd "${MY_DRIVER_S}"
	dodoc README Release.notes TODO known_bugs.txt

	cd "${MY_FRONTEND_S}"
	einstall "DESTDIR=${D}" || die "install failed"
}
