# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-driver/madwifi-driver-0.1_pre20030802.ebuild,v 1.1 2003/08/03 18:04:02 sediener Exp $

MY_PN="${PN/-driver/}"
MY_PV="${PV/0.1_pre/}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Wireless driver for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	check_KV
	unpack ${A}

	einfo "${KV}"

	cd ${S}
	mv Makefile.inc ${T}
	sed -e "s:\$(shell uname -r):${KV}:" \
		-e "s:\${DEPTH\}/../:/usr/src/:" \
		${T}/Makefile.inc > Makefile.inc
}

src_compile() {
	make clean
	make || die
}

src_install() {
	dodir /lib/modules/${KV}/net
	insinto /lib/modules/${KV}/net
	doins ${S}/wlan/wlan.o ${S}/ath_hal/ath_hal.o ${S}/driver/ath_pci.o

	dodoc README
}

pkg_postinst() {
	depmod -a
	einfo ""
	einfo "The madwifi drivers create an interface named 'athX'"
	einfo "Create /etc/init.d/net.ath0 and add a line for athX"
	einfo "in /etc/conf.d/net like 'iface_ath0=\"dhcp\"'"
	einfo ""
}
