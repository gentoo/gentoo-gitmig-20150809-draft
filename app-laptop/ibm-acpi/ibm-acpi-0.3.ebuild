# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/ibm-acpi/ibm-acpi-0.3.ebuild,v 1.1 2004/09/02 16:50:21 brix Exp $

inherit kernel-mod

DESCRIPTION="IBM ThinkPad ACPI extras"

HOMEPAGE=""
SRC_URI="http://bkernel.sf.net/tmp/ibm-acpi-0.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

src_unpack() {
	if ! egrep "^CONFIG_ACPI=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "${PN} requires an ACPI (CONFIG_ACPI) enabled kernel."
		eerror ""
		die "Kernel ACPI support not detected."
	fi

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
	dodoc etc/acpi/actions/*

	docinto examples/etc/acpi/events
	dodoc etc/acpi/events/*
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
