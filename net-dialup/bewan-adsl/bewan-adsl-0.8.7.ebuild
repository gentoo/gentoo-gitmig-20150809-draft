# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/bewan-adsl/bewan-adsl-0.8.7.ebuild,v 1.4 2004/12/14 21:20:09 mrness Exp $

inherit eutils linux-mod

DESCRIPTION="Bewan ADSL PCI&USB st driver"
SRC_URI="http://www.bewan.com/bewan/drivers/bast-${PV}.tgz"
HOMEPAGE="http://www.bewan.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="usb doc"
DEPEND="virtual/linux-sources"

S="${WORKDIR}/unicorn"

PCI_S="${S}/unicorn_pci"
USB_S="${S}/unicorn_usb"
BUILD_PARAMS="KERNEL_SOURCES=${KV_DIR} KVERS=${KV_FULL}"
BUILD_TARGETS="modules"
CONFIG_CHECK="ATM"
ATM_ERROR="This driver requires you to build your kernel with support for Asynchronous Transfer Mode (ATM)"

pkg_setup() {
	MODULE_NAMES="unicorn_pci_atm(extra:${PCI_S}) unicorn_pci_eth(extra:${PCI_S})"
	useq usb && MODULE_NAMES="${MODULE_NAMES} unicorn_usb_atm(extra:${USB_S})"

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	#As of Linux 2.6.9, timeout is no longer in the URB structure, see:
	#http://linux.bkbits.net:8080/linux-2.6/cset@1.1832.8.20
	if [ ${KV_MINOR} -ge 6 ] && [ ${KV_PATCH} -ge 9 ]; then
		epatch ${FILESDIR}/bewan-adsl-kill-timeout.patch
	fi

	# Fix up broken Makefiles
	convert_to_m ${PCI_S}/Makefile
	useq usb && convert_to_m ${USB_S}/Makefile
}

src_compile() {
	einfo "Build common library"
	cd ${S}/libm
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
	unset ARCH #unset ARCH because interfere with 2.6 kernel makefiles

	einfo "Building tools"
	cd ${S}/tools
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	cd ${S}
	#Install tools
	dodir /usr/bin
	cd ${S}/tools && einstall DESTDIR=${D} prefix=/usr || \
		die "Cannot install tools"

	if useq doc; then
		#Install documantation	
		cd ${S}
		dodoc README
		docinto Documentation
		dodoc Documentation/*
		docinto RFCs
		dodoc RFCs/*
		docinto scripts
		dodoc scripts/*
	fi
}

pkg_postinst() {
	einfo "To load the driver do 'modprobe unicorn_atm' and 'modprobe unicorn_pci' "
	einfo "and then do what you want with it (configure your pppd)"
	einfo "OR"
	einfo "it's time to look at the README file, the scripts directory gives you"
	einfo "two comprehensive ways to load the driver, configure pppd and launch it."

	linux-mod_pkg_postinst
}
