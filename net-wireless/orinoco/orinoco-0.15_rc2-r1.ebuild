# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/orinoco/orinoco-0.15_rc2-r1.ebuild,v 1.2 2005/01/04 10:05:58 brix Exp $

inherit pcmcia linux-mod

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ORiNOCO wireless driver"
HOMEPAGE="http://www.nongnu.org/orinoco/"
SRC_URI="${SRC_URI} http://www.ozlabs.org/people/dgibson/dldwd/${MY_P}.tar.gz"
LICENSE="GPL-2 MPL-1.1"

KEYWORDS="~x86 ~ppc"
IUSE="pcmcia"
SLOT="0"

RDEPEND="net-wireless/wireless-tools"

BUILD_TARGETS="all"

MODULESD_ORINOCO_DOCS="README.orinoco"

CONFIG_CHECK="NET_RADIO !HERMES"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
HERMES_ERROR="${P} requires Hermes chipset 802.11b support (Orinoco/Prism2/Symbol) (CONFIG_HERMES) to be DISABLED."

pkg_setup() {
	MODULE_NAMES="hermes(net:)
				orinoco(net:)
				orinoco_nortel(net:)
				orinoco_pci(net:)
				orinoco_plx(net:)
				orinoco_tmd(net:)"

	if use pcmcia; then
		MODULE_NAMES="${MODULE_NAMES} orinoco_cs(net:) spectrum_cs(net:)"
	fi

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	pcmcia_src_unpack

	if [ -n "${PCMCIA_VERSION}" ]; then
		sed -i "s:^\(PCMCIA_CS\) =.*:\1 = ${PCMCIA_SOURCE_DIR}:" \
			${S}/Makefile
	fi

	sed -i "s:^\(KERNEL_SRC\) =.*:\1 = ${ROOT}/usr/src/linux/:" \
		${S}/Makefile

	convert_to_m ${S}/Makefile
}

src_compile() {
	pcmcia_configure

	linux-mod_src_compile
}

src_install() {
	if use pcmcia; then
		insinto /etc/pcmcia
		doins hermes.conf
	fi

	linux-mod_src_install
}
