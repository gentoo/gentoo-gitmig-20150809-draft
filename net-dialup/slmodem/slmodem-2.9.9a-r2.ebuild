# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.9a-r2.ebuild,v 1.1 2005/01/22 02:33:26 mrness Exp $

inherit eutils linux-mod

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://linmodems.technion.ac.il/packages/smartlink/"
SRC_URI="http://linmodems.technion.ac.il/packages/smartlink/${P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="x86 -*"
IUSE="alsa usb"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	>=sys-apps/sed-4"

RDEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )"

pkg_setup() {
	MODULE_NAMES="slamr(extra:${S}/drivers)"
	useq usb && MODULE_NAMES="${MODULE_NAMES} slusb(extra:${S}/drivers)"
	BUILD_TARGETS="all"

	local CONFIG_CHECK=""
	if useq alsa; then
		CONFIG_CHECK="${CONFIG_CHECK} SND"
	fi
	if useq usb; then
		CONFIG_CHECK="${CONFIG_CHECK} USB"
	fi

	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-usb_endpoint_halted-gentoo.patch || die "failed to apply usb_endpoint patch"
	epatch ${FILESDIR}/${P}-alsa.patch || die "failed to apply alsa patch"

	convert_to_m drivers/Makefile
}

src_compile() {
	local MAKE_PARAMS=""
	if useq alsa; then
		MAKE_PARAMS="SUPPORT_ALSA=1"
	fi
	emake ${MAKE_PARAMS} modem || die "failed to build modem"

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	cd ${S}
	newsbin modem/modem_test slmodem_test
	dosbin modem/slmodemd
	dodir /var/lib/slmodem
	fowners root:dialout /var/lib/slmodem
	keepdir /var/lib/slmodem

	dodoc COPYING Changes README

	# Install /etc/{devfs,modules,init,conf}.d/slmodem files
	insinto /etc/conf.d/; newins ${FILESDIR}/${PN}-2.9.conf ${PN}
	insopts -m0755; insinto /etc/init.d/; newins ${FILESDIR}/${PN}-2.9.init ${PN}
	sed -i -e "s/ALSACONF//g" -e "s/PCICONF//g" -e "s/USBCONF//g" ${D}/etc/conf.d/slmodem

	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ] ; then
		# devfs
		insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.9.devfs ${PN}
	elif [ -e ${ROOT}/dev/.udev ] ; then
		# udev
		# check Symlink
		dodir /etc/udev/rules.d/
		echo 'KERNEL="slamr", NAME="slamr0"' > \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
		echo 'KERNEL="slusb", NAME="slusb0"' >> \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
		dodir /etc/udev/permissions.d
		echo 'slamr*:root:dialout:0660' > \
			${D}/etc/udev/permissions.d/55-${PN}.permissions
	fi

	#Create device nodes, add module aliases and install hotplug script
	make -C drivers DESTDIR=${D} KERNEL_DIR="${ROOT}/usr/src/linux" install-devices
	insinto /etc/modules.d/; insopts -m0644; newins ${FILESDIR}/${PN}-2.9.modules ${PN}
	useq usb &&
		( insinto /etc/hotplug/usb; insopts -m0755; newins ${FILESDIR}/slusb.hotplug slusb )

	dodir /etc/hotplug/blacklist.d
	echo -e "slusb\nslamr\nsnd-intel8x0m" >> ${D}/etc/hotplug/blacklist.d/55-${PN}
}

pkg_postinst() {
	linux-mod_pkg_postinst

	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ]; then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend $?

	elif [ -e ${ROOT}/dev/.udev ]; then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend $?
	fi

	if [ ! -e ${ROOT}/dev/ppp ]; then
		mknod ${ROOT}/dev/ppp c 108 0
	fi

	ewarn "To avoid problems, slusb/slamr have been added to /etc/hotplug/blacklist"
	einfo "You must edit /etc/conf.d/${PN} for your configuration"
	einfo "To add slmodem to your startup - type : rc-update add slmodem default"

	if use alsa; then
		einfo "I hope you have already added alsa to your startup: "
		einfo "otherwise type: rc-update add alsasound boot"
		einfo
		einfo "If you need to use snd-intel8x0m from the kernel"
		einfo "compile it as a module and edit /etc/module.d/alsa"
		einfo 'to: "alias snd-card-(number) snd-intel8x0m"'
	fi
}
