# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/bewan-adsl/bewan-adsl-0.8.7.ebuild,v 1.3 2004/12/05 21:17:16 mrness Exp $

inherit eutils linux-info

DESCRIPTION="Bewan ADSL PCI&USB st driver"
SRC_URI="http://www.bewan.com/bewan/drivers/bast-${PV}.tgz"
HOMEPAGE="http://www.bewan.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="usb doc"

S="${WORKDIR}/unicorn"

src_compile() {

	einfo "Build common library"
	cd ${S}/libm
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
	unset ARCH #unset ARCH because interfere with 2.6 kernel makefiles

	einfo "Build PCI driver"
	cd ${S}/unicorn_pci
	emake || die "Failed to build PCI driver"

	if use usb; then
		einfo "Build USB driver"
		cd ${S}/unicorn_usb
		emake || die "Failed to build USB driver"
	fi

	#Build tools
	cd ${S}/tools
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	if kernel_is 2 6 ; then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	cd ${S}
	insinto "/lib/modules/${KV}/kernel/drivers/atm"
	doins unicorn_pci/unicorn_pci_atm.${KV_OBJ} && \
		doins unicorn_pci/unicorn_pci_eth.${KV_OBJ} || \
		die "PCI driver not found! Install aborted."
	if use usb; then
		doins unicorn_usb/unicorn_usb_atm.${KV_OBJ} && \
			doins unicorn_usb/unicorn_usb_eth.${KV_OBJ} || \
			die "USB driver not found! Install aborted."
	fi

	#Install tools
	dodir /usr/bin
	cd ${S}/tools && einstall DESTDIR=${D} prefix=/usr || \
		die "Cannot install tools"

	if use doc; then
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
	einfo "To load the driver do 'insmod unicorn_atm' and 'insmod unicorn_pci' "
	einfo "and then do what you want with it (configure your pppd)"
	einfo "OR"
	einfo "it's time to look at the README file, the scripts directory gives you"
	einfo "two comprehensive ways to load the driver, configure pppd and launch it."
	einfo ""

	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}

