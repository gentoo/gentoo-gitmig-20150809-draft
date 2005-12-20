# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gigaset-isdn/gigaset-isdn-0.5.0.ebuild,v 1.1 2005/12/20 19:35:47 mrness Exp $

inherit linux-mod


DESCRIPTION="Kernel driver for Gigaset 307x/417x/SX353/USB Adapter DECT/M105/M101 and compatible ISDN adapters"
HOMEPAGE="http://gigaset307x.sourceforge.net/"
SRC_URI="mirror://sourceforge/gigaset307x/gigaset-driver-${PV}.tar.bz2
		mirror://sourceforge/gigaset307x/gigaset-frontend-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="virtual/linux-sources"

S="${WORKDIR}"

MODULE_NAMES="gigaset(drivers/isdn:) bas_gigaset(drivers/isdn:) ser_gigaset(drivers/isdn:) usb_gigaset(drivers/isdn:)"
BUILD_TARGETS="all"
CONFIG_CHECK="ISDN_I4L"
ISDN_I4L_ERROR="This driver requires that your kernel is compiled with support for ISDN4Linux (I4L)"

src_unpack() {
	unpack ${A}

	# Fix broken makefile
	convert_to_m "${WORKDIR}/gigaset-driver-${PV}/gigaset/Makefile.26.in"

	# Fix includes
	sed -i -e "s:^INCLUDEDIRS +=:INCLUDEDIRS += \"-I${WORKDIR}/gigaset-driver-${PV}/include\":" \
		${WORKDIR}/gigaset-frontend-${PV}/lib/Makefile
}


src_compile() {
	S="${WORKDIR}/gigaset-driver-${PV}"
	cd "${S}"
	./configure --kernel=${KV_FULL} --kerneldir=${KV_DIR} --root=${D} --prefix=/usr \
		--with-ring $(use_with debug)
	linux-mod_src_compile

	S="${WORKDIR}/gigaset-frontend-${PV}"
	cd "${S}"
	./configure --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install () {
	S="${WORKDIR}/gigaset-driver-${PV}/gigaset"
	linux-mod_src_install
	S=${WORKDIR}/gigaset-driver-${PV}
	#einstall ROOT=${D} || die "Failed to install frontend"
	dodoc README Release.notes TODO known_bugs.txt

	S="${WORKDIR}/gigaset-frontend-${PV}"
	cd "${S}"
	einstall "DESTDIR=${D}" || die "install failed"
}
