# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.9d.ebuild,v 1.5 2005/07/11 15:15:30 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://linmodems.technion.ac.il/packages/smartlink/"
SRC_URI="http://linmodems.technion.ac.il/packages/smartlink/${P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="x86 -*"
IUSE="alsa usb"

RDEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	MODULE_NAMES="slamr(net:${S}/drivers)"
	if useq usb; then
		MODULE_NAMES="${MODULE_NAMES} slusb(net:${S}/drivers)"
		CONFIG_CHECK="USB"
	fi
	BUILD_TARGETS="all"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-2.9.9b-gcc4.patch

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

	insinto /etc/conf.d/; newins ${FILESDIR}/${PN}-2.9.conf ${PN}
	exeinto /etc/init.d/; newexe ${FILESDIR}/${PN}-2.9.init ${PN}

	# configure for alsa - or not for alsa
	if useq alsa; then
		sed -i -e "s/# MODULE=alsa/MODULE=alsa/" \
			-e "s/# HW_SLOT=modem:1/HW_SLOT=modem:1/" ${D}/etc/conf.d/slmodem
	else
		sed -i "s/# MODULE=slamr/MODULE=slamr/" ${D}/etc/conf.d/slmodem
	fi


	# Add module aliases and install hotplug script
	insinto /etc/modules.d/; newins ${FILESDIR}/${PN}-2.9.modules ${PN}
	if useq usb; then
		exeinto /etc/hotplug/usb; newexe ${FILESDIR}/slusb.hotplug slusb
	fi

	dodir /etc/hotplug/blacklist.d
	echo -e "slusb\nslamr\nsnd-intel8x0m" >> ${D}/etc/hotplug/blacklist.d/${PN}

	# Add configuration for devfs, udev
	if [ -e ${ROOT}/dev/.devfsd ] ; then
		insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.9.devfs ${PN}
	elif [ -e ${ROOT}/dev/.udev ] ; then
		dodir /etc/udev/rules.d/
		echo 'KERNEL="slamr", NAME="slamr0" GROUP="dialout"' > \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
		echo 'KERNEL="slusb", NAME="slusb0" GROUP="dialout"' >> \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
	fi

	dodoc COPYING Changes README
}

pkg_postinst() {
	linux-mod_pkg_postinst

	# Make some devices if we aren't using devfs or udev
	if [ -e ${ROOT}/dev/.devfsd ]; then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend $?

	elif [ -e ${ROOT}/dev/.udev ]; then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend $?
	else
		cd ${S}/drivers
		make DESTDIR=${ROOT} install-devices
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

	einfo "You need to be in the uucp AND dialout group to make calls as a user."
}
