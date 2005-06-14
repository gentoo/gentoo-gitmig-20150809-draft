# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/orinoco-cvs/orinoco-cvs-0.15_rc2.ebuild,v 1.1 2005/06/14 19:17:27 brix Exp $

inherit eutils linux-mod cvs

ECVS_SERVER="savannah.nongnu.org:/cvsroot/orinoco"
ECVS_MODULE="orinoco"
ECVS_AUTH="ext"
ECVS_USER="anoncvs"
ECVS_SSH_HOST_KEY="savannah.nongnu.org,199.232.41.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="ORiNOCO IEEE 802.11 wireless LAN driver"
HOMEPAGE="http://www.nongnu.org/orinoco/"
SRC_URI=""
LICENSE="GPL-2 MPL-1.1"

KEYWORDS="~x86"
IUSE="pcmcia usb"
SLOT="0"

RDEPEND="net-wireless/wireless-tools
		usb? ( net-wireless/orinoco-usb-firmware )
		!net-wireless/orinoco"

BUILD_TARGETS="all"
MODULESD_ORINOCO_DOCS="README.orinoco"

CONFIG_CHECK="NET_RADIO !HERMES"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_HERMES="${P} requires Hermes chipset 802.11b support (Orinoco/Prism2/Symbol) (CONFIG_HERMES) to be DISABLED."

pkg_setup() {
	linux-mod_pkg_setup

	MODULE_NAMES="hermes(net:)
				  orinoco(net:)"

	if linux_chkconfig_present PCI; then
		einfo "PCI support detected"
		MODULE_NAMES="${MODULE_NAMES} orinoco_nortel(net:) orinoco_pci(net:) orinoco_plx(net:) orinoco_tmd(net:)"
	fi

	if linux_chkconfig_present PPC_PMAC; then
		einfo "PPC PowerMac support detected"
		MODULE_NAMES="${MODULE_NAMES} airport(net:)"
	fi

	if use pcmcia; then
		einfo "PCMCIA support detected"

		MODULE_NAMES="${MODULE_NAMES} orinoco_cs(net:)"

		if kernel_is gt 2 4 && linux_chkconfig_present FW_LOADER; then
			einfo "Firmware loader support detected"
			MODULE_NAMES="${MODULE_NAMES} spectrum_cs(net:)"
		fi
	fi

	if use usb; then
		einfo "USB support detected"

		MODULE_NAMES="${MODULE_NAMES} prism_usb(net:)"

		if kernel_is gt 2 4 && linux_chkconfig_present FW_LOADER; then
			einfo "Firmware loader support detected"
			MODULE_NAMES="${MODULE_NAMES} orinoco_usb(net:)"
		fi
	fi
}

src_unpack() {
	cvs_src_unpack
	pcmcia_src_unpack

	if [[ -n "${PCMCIA_VERSION}" ]]; then
		sed -i -e "s:^\(PCMCIA_CS\) =.*:\1 = ${PCMCIA_SOURCE_DIR}:" \
			${S}/Makefile
	fi

	sed -i "s:^\(KERNEL_SRC\) =.*:\1 = ${KV_DIR}:" \
		${S}/Makefile

	convert_to_m ${S}/Makefile
}

src_install() {
	if use pcmcia; then
		insinto /etc/pcmcia
		doins hermes.conf
	fi

	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [[ -e ${ROOT}/lib/modules/${KV_FULL}/pcmcia/orinoco.${KV_OBJ} ]]; then
		ewarn
		ewarn "The modules from this package conflicts with the modules installed"
		ewarn "by the pcmcia-cs package. You will have to manually delete the"
		ewarn "duplicate modules from the"
		ewarn "  ${ROOT}lib/modules/${KV_FULL}/pcmcia/"
		ewarn "directory and manually run '/sbin/depmod -ae'"
		ewarn
	fi
}
