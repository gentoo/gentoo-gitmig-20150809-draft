# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.10-r1.ebuild,v 1.2 2004/10/24 20:57:15 dragonheart Exp $

inherit kernel-mod eutils

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://www.smlink.com/"
SRC_URI="http://www.smlink.com/main/down/${P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE="alsa usb"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	virtual/os-headers
	>=sys-apps/sed-4"

RDEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )"

pkg_setup() {
	kernel-mod_check_modules_supported
}

src_compile() {
	if use alsa
	then
		export SUPPORT_ALSA=1
	else
		unset SUPPORT_ALSA
	fi

	# http://marc.theaimsgroup.com/?l=gentoo-dev&m=109672618708314&w=2
	kernel-mod_getversion
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' drivers/Makefile
	fi

	unset ARCH

	emake \
		KERNEL_DIR="${ROOT}/usr/src/linux" \
	 	modem drivers || die "Failed to compile driver"
}

src_install() {
	if kernel-mod_is_2_6_kernel
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	insinto /lib/modules/${KV}/extra
	doins drivers/slamr.${KV_OBJ}
	doins drivers/slusb.${KV_OBJ}

	newsbin modem/modem_test slmodem_test
	dosbin modem/slmodemd
	dodir /var/lib/slmodem
	fowners root:dialout /var/lib/slmodem

	dodoc COPYING Changes README

	# Install /etc/{devfs,modules,init,conf}.d/slmodem files
	insinto /etc/conf.d/; newins ${FILESDIR}/${PN}-2.9.conf ${PN}
	insopts -m0755; insinto /etc/init.d/; newins ${FILESDIR}/${PN}-2.9.init ${PN}

	if use alsa
	then
		sed -i -e "s/# ALSACONF //g" ${D}/etc/conf.d/slmodem
	else
		sed -i -e "s/# NONALSACONF //g" ${D}/etc/conf.d/slmodem
		if use usb
		then
			sed -i -e "s/# USBCONF //g" ${D}/etc/conf.d/slmodem
		else
			sed -i -e "s/# PCICONF //g" ${D}/etc/conf.d/slmodem
		fi
	fi
	sed -i -e "s/ALSACONF//g" -e "s/PCICONF//g" -e "s/USBCONF//g" ${D}/etc/conf.d/slmodem


	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ] ; then
	# devfs
		insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.9.devfs ${PN}
		insinto /etc/modules.d/; newins ${FILESDIR}/${PN}-2.9.modules ${PN}
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
	else
		make -C drivers DESTDIR=${D} KERNEL_DIR="${ROOT}/usr/src/linux" install-devices
	fi

	dodir /etc/hotplug/blacklist.d
	echo -e "slusb\nslamr\nsnd-intel8x0m" >> ${D}/etc/hotplug/blacklist.d/55-${PN}
}

pkg_postinst() {
	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ]
	then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend 0
		einfo "modules-update to complete configuration."

	elif [ -e ${ROOT}/dev/.udev ]
	then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend 0
	fi

	echo

	einfo "You must edit /etc/conf.d/${PN} for your configuration"

	ewarn "To avoid problems add slusb/slamr to /etc/hotplug/blacklist"

	einfo "To add slmodem to your startup - type : rc-update add slmodem default"

	if use alsa;
	then
		einfo "I hope you have already added alsa to your startup: "
		einfo "otherwise type: rc-update add alsasound boot"
		einfo
		einfo "If you need to use snd-intel8x0m from the kernel"
		einfo "compile it as a module and edit /etc/module.d/alsa"
		einfo 'to: "alias snd-card-(number) snd-intel8x0m"'
	fi

	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
