# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/ibm-acpi/ibm-acpi-0.11-r1.ebuild,v 1.3 2005/08/08 17:14:03 brix Exp $

inherit linux-mod

DESCRIPTION="IBM ThinkPad ACPI extras"

HOMEPAGE="http://ibm-acpi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

IUSE="doc"

BUILD_PARAMS="KDIR=${KV_DIR}"
BUILD_TARGETS="default"
MODULE_NAMES="ibm_acpi(acpi:)"
MODULESD_IBM_ACPI_DOCS="README"

CONFIG_CHECK="!ACPI_IBM ACPI"
ACPI_IBM_ERROR="${P} requires IBM ThinkPad Laptop Extras (CONFIG_ACPI_IBM) to be DISABLED in the kernel."
ACPI_ERROR="${P} requires an ACPI (CONFIG_ACPI) enabled kernel."

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} does not support kernel 2.4.x"
	fi

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	exeinto /sbin
	newexe ${S}/config/usr/local/sbin/idectl idectl-${PN}

	if use doc; then
		docinto examples/etc/acpi/actions
		dodoc config/etc/acpi/actions/*

		docinto examples/etc/acpi/events
		dodoc config/etc/acpi/events/*
	fi
}

pkg_postinst() {
	einfo ""
	einfo "You may wish to install sys-power/acpid to handle the ACPI events generated"
	einfo "by ${PN}."

	if useq doc; then
		einfo ""
		einfo "Example acpid configuration has been installed to"
		einfo "/usr/share/doc/${PF}/examples/"
	fi

	einfo ""
	einfo "For further instructions please see /usr/share/doc/${PF}/README.gz"
	einfo ""

	linux-mod_pkg_postinst
}
