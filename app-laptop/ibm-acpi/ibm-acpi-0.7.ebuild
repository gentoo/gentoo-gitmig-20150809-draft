# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/ibm-acpi/ibm-acpi-0.7.ebuild,v 1.2 2004/10/24 14:12:47 brix Exp $

inherit kernel-mod eutils

DESCRIPTION="IBM ThinkPad ACPI extras"

HOMEPAGE="http://ibm-acpi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"

DEPEND="virtual/linux-sources
		sys-apps/sed"

src_unpack() {
	kernel-mod_check_modules_supported

	if ! kernel-mod_configoption_present ACPI
	then
		eerror ""
		eerror "${PN} requires support for ACPI (CONFIG_ACPI) in the kernel."
		eerror ""
		die "CONFIG_ACPI support not detected."
	fi

	unpack ${A}

	# let pkg_postinst() handle depmod
	sed -i "s:depmod -a::" ${S}/Makefile

	kernel-mod_getversion

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/Makefile
	fi
}

src_compile() {
	set_arch_to_kernel

	emake KDIR=${ROOT}/usr/src/linux || die
}

src_install() {
	set_arch_to_kernel

	emake MDIR=${D}/lib/modules/${KV}/acpi install || die

	set_arch_to_portage

	dodoc LICENSE README

	if use doc; then
		docinto examples/etc/acpi/actions
		dodoc config/etc/acpi/actions/*

		docinto examples/etc/acpi/events
		dodoc config/etc/acpi/events/*
	fi
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}

	einfo ""
	einfo "You may wish to install sys-apps/acpid to handle the ACPI events generated"
	einfo "by ${PN}."

	if use doc &> /dev/null; then
		einfo ""
		einfo "Example acpid configuration has been installed to"
		einfo "/usr/share/doc/${PF}/examples/"
	fi

	einfo ""
	einfo "For further instructions please see /usr/share/doc/${PF}/README.gz"
	einfo ""
}
