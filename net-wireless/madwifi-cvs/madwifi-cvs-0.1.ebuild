# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-cvs/madwifi-cvs-0.1.ebuild,v 1.1 2003/11/10 14:49:23 sediener Exp $

DESCRIPTION="Multiband Atheros Driver for WiFi"
HOMEPAGE="http://sourceforge.net/projects/madwifi/"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="-* ~x86"
IUSE=""
DEPEND=" !net-wireless/madwifi-driver"

inherit cvs

ECVS_USER="anonymous"
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/madwifi"
ECVS_MODULE="madwifi"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	check_KV
	einfo "${KV}"

	cd ${S}
	mv Makefile.inc ${T}
	sed -e "s:\$(shell uname -r):${KV}:" \
		-e "s:\${DEPTH\}/../:/usr/src/:" \
		${T}/Makefile.inc > Makefile.inc

	make || die
}

src_install() {
	dodir /lib/modules/${KV}/net
	insinto /lib/modules/${KV}/net
	doins ${S}/wlan/wlan.o ${S}/ath_hal/ath_hal.o ${S}/driver/ath_pci.o

	dodoc README COPYRIGHT
}


pkg_postinst() {
	depmod -a
	einfo ""
	einfo "The madwifi drivers create an interface named 'athX'"
	einfo "Create /etc/init.d/net.ath0 and add a line for athX"
	einfo "in /etc/conf.d/net like 'iface_ath0=\"dhcp\"'"
	einfo ""
}
