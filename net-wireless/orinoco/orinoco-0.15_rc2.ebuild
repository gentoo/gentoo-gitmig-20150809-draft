# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/orinoco/orinoco-0.15_rc2.ebuild,v 1.1 2004/11/01 12:22:47 brix Exp $

inherit eutils kernel-mod pcmcia

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="ORiNOCO wireless driver"
HOMEPAGE="http://www.nongnu.org/orinoco/"
SRC_URI="${SRC_URI} http://www.ozlabs.org/people/dgibson/dldwd/${MY_P}.tar.gz"
LICENSE="GPL-2 MPL-1.1"

KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="0"

DEPEND="virtual/linux-sources
		sys-apps/sed"
RDEPEND="net-wireless/wireless-tools"

pkg_setup () {
	local DIE=0

	if kernel-mod_configoption_present HERMES
	then
		eerror ""
		eerror "${P} requires Hermes chipset 802.11b support (Orinoco/Prism2/Symbol)"
		eerror "to be DISABLED in the kernel to avoid conflicting modules."
		DIE=1
	fi

	if ! kernel-mod_configoption_present NET_RADIO
	then
		eerror ""
		eerror "${P} requires support for Wireless LAN drivers (non-hamradio) &"
		eerror "Wireless Extensions (CONFIG_NET_RADIO) in the kernel."
		DIE=1
	fi

	kernel-mod_check_modules_supported

	if [ $DIE -eq 1 ]
	then
		eerror ""
		die "You kernel is missing the required option(s) listed above."
	fi
}

src_unpack() {
	unpack ${A}

	pcmcia_src_unpack

	if [ -n "${PCMCIA_VERSION}" ]
	then
		sed -i "s:^\(PCMCIA_CS\) =.*:\1 = ${PCMCIA_SOURCE_DIR}:" \
			${S}/Makefile
	fi

	sed -i "s:^\(KERNEL_SRC\) =.*:\1 = ${ROOT}/usr/src/linux/:" \
		${S}/Makefile

	sed -i "s:^\(CONF_DIR\) = \(.*\):\1 = ${D}\2:" \
		${S}/Makefile

	sed -i "s:^\(MODULE_DIR_TOP\) = \(.*\):\1 = ${D}\2:" \
		${S}/Makefile

	sed -i "s:^\(MODULE_DIR_WIRELESS = \$(MODULE_DIR_TOP)\).*:\1/net:" \
		${S}/Makefile

	sed -i "s:\$(DEPMOD).*::" ${S}/Makefile

	kernel-mod_getversion

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i "s:SUBDIRS=:M=:" ${S}/Makefile
	fi
}

src_compile() {
	pcmcia_configure

	set_arch_to_kernel
	emake || die "emake failed"
	set_arch_to_portage
}

src_install() {
	set_arch_to_kernel
	emake install || die "emake install failed"
	set_arch_to_portage

	dodoc README.orinoco
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
