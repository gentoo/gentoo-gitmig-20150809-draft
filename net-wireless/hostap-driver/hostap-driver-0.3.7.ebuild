# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap-driver/hostap-driver-0.3.7.ebuild,v 1.5 2005/08/13 16:06:58 brix Exp $

inherit toolchain-funcs eutils linux-mod

DESCRIPTION="Driver for Intersil Prism2/2.5/3 based IEEE 802.11b wireless LAN products"
HOMEPAGE="http://hostap.epitest.fi"
SRC_URI="${SRC_URI} http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="ppc x86"
IUSE="pcmcia"
SLOT="0"

RDEPEND=">=net-wireless/wireless-tools-25"

BUILD_PARAMS="KERNEL_PATH=${KV_DIR}"
BUILD_TARGETS="all"
MODULESD_HOSTAP_DOCS="README"

CONFIG_CHECK="NET_RADIO"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	MODULE_NAMES="hostap(net::${S}/driver/modules)
				hostap_pci(net::${S}/driver/modules)
				hostap_plx(net::${S}/driver/modules)
				hostap_crypt_wep(net::${S}/driver/modules)
				hostap_crypt_ccmp(net::${S}/driver/modules)
				hostap_crypt_tkip(net::${S}/driver/modules)"

	if use pcmcia; then
		MODULE_NAMES="${MODULE_NAMES} hostap_cs(net::${S}/driver/modules)"
	fi

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-firmware.patch

	sed -i \
		-e "s:gcc:$(tc-getCC):" \
		-e "s:tail -1:tail -n 1:" \
		${S}/Makefile

	if use pcmcia; then
		# unpack the pcmcia-cs sources if needed
		pcmcia_src_unpack

		# set correct pcmcia path (PCMCIA_VERSION gets set from pcmcia_src_unpack)
		if [ -n "${PCMCIA_VERSION}" ]; then
			sed -i "s:^\(PCMCIA_PATH\)=:\1=${PCMCIA_SOURCE_DIR}:" ${S}/Makefile
		fi
	fi

	convert_to_m ${S}/Makefile
}

src_install() {
	if use pcmcia; then
		insinto /etc/pcmcia
		doins driver/etc/hostap_cs.conf
	fi

	dodoc ChangeLog

	linux-mod_src_install
}

pkg_postinst() {
	if [ -e /etc/pcmcia/prism2.conf ]
	then
		einfo ""
		einfo "You may need to edit or remove /etc/pcmcia/prism2.conf"
		einfo "This is usually a result of conflicts with the"
		einfo "net-wireless/linux-wlan-ng drivers."
		einfo ""
	fi

	einfo ""
	einfo "Please notice that all ${PN} modules are now installed to"
	einfo "/lib/modules/${KV}/net/."
	einfo ""
	einfo "You may have to manually delete the old modules if upgrading from from"
	einfo "<=net-wireless/${PN}-0.2.4."
	einfo ""

	ewarn ""
	ewarn "Please note that this installation of HostAP contains support"
	ewarn "for downloading binary firmware images into the non-volatile"
	ewarn "(permanent) flash memory of wireless LAN cards."
	ewarn ""
	ewarn "Albeit being a great feature, this can lead to A DEAD CARD"
	ewarn "when inappropriately used (e.g. wrong firmware)."
	ewarn ""

	linux-mod_pkg_postinst
}
