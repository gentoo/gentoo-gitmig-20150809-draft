# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/orinoco/orinoco-9999.ebuild,v 1.1 2005/11/27 18:54:04 brix Exp $

inherit linux-mod cvs

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
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="pcmcia usb"
RDEPEND="net-wireless/wireless-tools"

BUILD_TARGETS="all"
MODULESD_ORINOCO_DOCS="README.orinoco"

CONFIG_CHECK="~FW_LOADER !HERMES NET_RADIO ~PCI ~PCMCIA ~USB"
ERROR_HERMES="${P} requires Hermes chipset 802.11b support (Orinoco/Prism2/Symbol) (CONFIG_HERMES) to be DISABLED."
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
MODULESD_ORINOCO_NORTEL_ENABLED="no"
MODULESD_ORINOCO_PCI_ENABLED="no"
MODULESD_ORINOCO_PLX_ENABLED="no"
MODULESD_ORINOCO_TMD_ENABLED="no"
MODULESD_PRISM_USB_ENABLED="no"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 11; then
		eerror
		eerror "${P} requires kernel 2.6.11 or above."
		eerror
		die "Kernel version too old."
	fi

	BUILD_PARAMS="KERNEL_PATH=${KV_DIR}"

	MODULE_NAMES="hermes(net/wireless:)
				  orinoco(net/wireless:)"

	if linux_chkconfig_present PCI; then
		MODULE_NAMES="${MODULE_NAMES}
					orinoco_nortel(net/wireless:)
					orinoco_pci(net/wireless:)
					orinoco_plx(net/wireless:)
					orinoco_tmd(net/wireless:)"
	fi

	if linux_chkconfig_present PPC_PMAC; then
		MODULE_NAMES="${MODULE_NAMES} airport(net/wireless:)"
	fi

	if use pcmcia && linux_chkconfig_present PCMCIA; then
		MODULE_NAMES="${MODULE_NAMES} orinoco_cs(net/wireless:)"

		if linux_chkconfig_present FW_LOADER; then
			MODULE_NAMES="${MODULE_NAMES} spectrum_cs(net/wireless:)"
		fi
	fi

	if use usb && linux_chkconfig_present USB; then
		MODULE_NAMES="${MODULE_NAMES} prism_usb(net/wireless:)"
	fi
}

src_compile() {
	linux-mod_src_compile

	if use pcmcia; then
		emake hermes.conf
	fi
}

src_install() {
	linux-mod_src_install

	dodoc NEWS TODO

	if use pcmcia; then
		insinto /etc/pcmcia
		doins hermes.conf
	fi
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
