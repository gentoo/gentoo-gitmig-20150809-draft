# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-modules/virtualbox-modules-4.0.2.ebuild,v 1.1 2011/01/18 19:29:58 polynomial-c Exp $

# XXX: the tarball here is just the kernel modules split out of the binary
#      package that comes from virtualbox-bin

EAPI=2

inherit eutils linux-mod

MY_P=vbox-kernel-module-src-${PV}
DESCRIPTION="Kernel Modules for Virtualbox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://dev.gentoo.org/~polynomial-c/virtualbox/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!=app-emulation/virtualbox-9999"

S=${WORKDIR}

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="vboxdrv(misc:${S}) vboxnetflt(misc:${S}) vboxnetadp(misc:${S})"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	enewgroup vboxusers
}

src_prepare() {
	if kernel_is -ge 2 6 33 ; then
		# evil patch for new kernels - header moved
		grep -lR linux/autoconf.h *  | xargs sed -i -e 's:<linux/autoconf.h>:<generated/autoconf.h>:'
	fi
}

src_install() {
	linux-mod_src_install

	# udev rule for vboxdrv
	dodir /etc/udev/rules.d
	echo '#SUBSYSTEM=="usb_device", GROUP="vboxusers", MODE="0644"' \
	> "${D}/etc/udev/rules.d/10-virtualbox.rules"
	echo '#SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", GROUP="vboxusers", MODE="0644"' \
	>> "${D}/etc/udev/rules.d/10-virtualbox.rules"
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "Starting with the 3.x release new kernel modules were added,"
	elog "be sure to load all the needed modules."
	elog ""
	elog "Please add \"vboxdrv\", \"vboxnetflt\" and \"vboxnetadp\" to:"
	if has_version sys-apps/openrc; then
		elog "/etc/conf.d/modules"
	else
		elog "/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
	fi
	elog ""
	elog "If you are experiencing problems on your guests"
	elog "with USB support and app-emulation/virtualbox-bin,"
	elog "uncomment the udev rules placed in:"
	elog ""
	elog "/etc/udev/rules.d/10-virtualbox.rules"
	elog ""
}
