# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.9.ebuild,v 1.2 2004/07/25 00:04:48 dragonheart Exp $

inherit kmod eutils

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://www.smlink.com/"
SRC_URI="http://www.smlink.com/main/down/${P}.tar.gz"
LICENSE="Smart-Link"
SLOT="${KV}"
KEYWORDS="~x86"
IUSE="alsa usb"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	virtual/os-headers"

RDEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	# Unpack and set some variables
	kmod_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${P}-makefile-fixup.patch
}

src_compile() {

	#[ -d ${KV_OUTPUT} ] || die "Build kernel ${KV_VERSION_FULL} first"

	export KERNEL_OUTPUT_DIR=${S}/workdir

	if is_kernel 2 5 || is_kernel 2 6
	then
		unset ARCH
	fi

	if use alsa
	then
		export SUPPORT_ALSA=1
	else
		export SUPPORT_ALSA=0
	fi

	mkdir ${S}/workdir

	emake -C ${S} \
		KERNEL_VER=${KV_VERSION_FULL} \
		KERNEL_DIR=${KV_OUTPUT} \
		KERNEL_INCLUDES=/usr/include/linux \
		all || die "Failed to compile driver"

}

#src_test() {
#	cd modem
#	emake modem_test
#	./modem_test || die "failed modem test"
#
#	if use usb
#	then
#	# USB modem test
#	else
#	# PCI modem test
#	fi
#}

src_install() {
	unset ARCH
	emake DESTDIR=${D} \
		KERNEL_VER=${KV_VERSION_FULL} \
		install-drivers \
		|| die "driver install failed"

	dosbin modem/slmodemd
	dodir /var/lib/slmodem
	fowners root:dialout /var/lib/slmodem

	dodoc COPYING Changes README

	# Install /etc/{devfs,modules,init,conf}.d/slmodem files
	insinto /etc/conf.d/; newins ${FILESDIR}/${PN}-2.9.conf ${PN}
	insopts -m0755; insinto /etc/init.d/; newins ${FILESDIR}/${PN}-2.9.init ${PN}

	if use alsa
	then
		sed -i -e "s/ALSA=.*/ALSA=yes/" -e "s:# DEV=/dev/ttySL0:DEV=/dev/ttySL0:" ${D}//etc/conf.d/slmodem
	else
		sed -i -e "s/ALSA=.*/ALSA=yes/" ${D}//etc/conf.d/slmodem
		if use usb
		then
			sed -i -e "s:# DEV=/dev/slusb0:DEV=/dev/slusb0:" ${D}//etc/conf.d/slmodem
		else
			sed -i -e "s:# DEV=/dev/slamr0:DEV=/dev/slamr0:" ${D}//etc/conf.d/slmodem
		fi
	fi


	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ] ; then
	# devfs
		insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.9.devfs ${PN}
		insinto /etc/modules.d/; newins ${FILESDIR}/${PN}-2.9.modules ${PN}
	elif [ -e ${ROOT}/dev/.udev ] ; then
	# udev
		# FIX Symlink
		dodir /etc/udev/rules.d/
		echo 'KERNEL="slamr", NAME="slamr0", SYMLINK="modem"' > \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
		dodir /etc/udev/permissions.d
		echo 'slamr*:root:dialout:0660' > \
			${D}/etc/udev/permissions.d/55-${PN}.permissions
	else
		make -C drivers DESTDIR=${D} KERNELRELEASE=1 KERNEL_VER=${KV_VERSION_FULL} install-devices
	fi

}

pkg_postinst() {
	kmod_pkg_postinst

	#depmod -a

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

	einfo "To add slmodem to your startup - type : rc-update add slmodem default"

	if use alsa;
	then
		einfo "I hope you have already added alsa to your startup: "
		einfo "otherwise type: rc-update add alsa-sound boot"
		einfo
		einfo "If you need to use snd-intel8x0m from the kernel"
		einfo "compile it as a module and edit /etc/module.d/alsa"
		einfo 'to: "alias snd-card-(number) snd-intel8x0m"'
	fi
}
