# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils linux-mod

MY_P=VirtualBox-OSE-${PV}
DESCRIPTION="Modules for Virtualbox OSE"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

RDEPEND="!<app-emulation/virtualbox-bin-1.3.6
	!<app-emulation/virtualbox-1.3.6
	!=app-emulation/virtualbox-9999"

S=${WORKDIR}/${MY_P}

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="vboxdrv(misc:${S}/src/VBox/HostDrivers/Support:${S}/src/VBox/HostDrivers/Support"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_unpack() {
	unpack "${A}"

	# Collect all the needed files for the kernel module
	cp -R "${S}"/src/VBox/Runtime/alloc "${S}"/src/VBox/HostDrivers/Support/
	mv "${S}"/src/VBox/HostDrivers/Support/alloc/heapsimple.cpp "${S}"/src/VBox/HostDrivers/Support/alloc/heapsimple.c
	mkdir -p "${S}"/src/VBox/HostDrivers/Support/include/
	cp -R "${S}"/include/iprt "${S}"/src/VBox/HostDrivers/Support/include/
	cp -R "${S}"/include/VBox "${S}"/src/VBox/HostDrivers/Support/include/
	cp -R "${S}"/src/VBox/Runtime/include/internal "${S}"/src/VBox/HostDrivers/Support/include/
	cp -R "${S}"/src/VBox/Runtime/r0drv "${S}"/src/VBox/HostDrivers/Support/
	mv "${S}"/src/VBox/HostDrivers/Support/r0drv/alloc-r0drv.cpp "${S}"/src/VBox/HostDrivers/Support/r0drv/alloc-r0drv.c
	mv "${S}"/src/VBox/HostDrivers/Support/r0drv/initterm-r0drv.cpp "${S}"/src/VBox/HostDrivers/Support/r0drv/initterm-r0drv.c

	# Use the proper Makefile
	mv "${S}"/src/VBox/HostDrivers/Support/linux/Makefile "${S}"/src/VBox/HostDrivers/Support/
}

src_install() {
	linux-mod_src_install

	# udev rule for vboxdrv
	dodir /etc/udev/rules.d
	echo 'KERNEL=="vboxdrv", GROUP="vboxusers" MODE=660' >> "${D}/etc/udev/rules.d/60-virtualbox.rules"
}

pkg_preinst() {
	enewgroup vboxusers
}

pkg_postinst() {
	if use amd64; then
		elog ""
		elog "To avoid the nmi_watchdog bug and load the vboxdrv module"
		elog "you may need to update your bootloader configuration and pass the option:"
		elog "nmi_watchdog=0"
	fi
}
