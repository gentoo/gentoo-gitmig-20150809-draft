# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/ibm-acpi/ibm-acpi-0.4.ebuild,v 1.5 2004/11/20 11:25:12 brix Exp $

inherit kernel-mod

DESCRIPTION="IBM ThinkPad ACPI extras"

HOMEPAGE="http://ibm-acpi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

pkg_setup() {
	local DIE=0

	if kernel-mod_is_2_4_kernel
	then
		die "${P} does not support kernel 2.4.x"
	fi

	if kernel-mod_configoption_present ACPI_IBM
	then
		eerror ""
		eerror "${P} requires IBM ThinkPad Laptop Extras (CONFIG_ACPI_IBM)"
		eerror "to be DISABLED in the kernel to avoid conflicting modules."
		DIE=1
	fi

	if ! kernel-mod_configoption_present ACPI
	then
		eerror ""
		eerror "${PN} requires an ACPI (CONFIG_ACPI) enabled kernel."
		eerror ""
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

	# let pkg_postinst() handle depmod
	sed -i -e "s:depmod -a::" ${S}/Makefile

	kernel-mod_getversion

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/Makefile
	fi
}

src_compile() {
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		unset ARCH
	fi

	emake KDIR=${ROOT}/usr/src/linux || die
}

src_install() {
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		unset ARCH
	fi

	emake MDIR=${D}/lib/modules/${KV}/acpi install || die

	dodoc LICENSE README

	docinto examples/etc/acpi/actions
	dodoc config/etc/acpi/actions/*

	docinto examples/etc/acpi/events
	dodoc config/etc/acpi/events/*
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}

	einfo ""
	einfo "You may wish to install sys-apps/acpid to handle the ACPI events generated"
	einfo "by ${P}.  Example acpid configuration has been installed to"
	einfo "/usr/share/doc/${PF}/examples/"
	einfo ""
	einfo "For further instructions please see /usr/share/doc/${PF}/README.gz"
	einfo ""
}
