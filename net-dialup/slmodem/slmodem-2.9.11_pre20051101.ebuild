# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.11_pre20051101.ebuild,v 1.5 2006/04/26 16:13:50 mrness Exp $

inherit eutils linux-mod multilib

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://linmodems.technion.ac.il/packages/smartlink/"
SRC_URI="http://linmodems.technion.ac.il/packages/smartlink/${P/_pre/-}.tar.gz
	http://linmodems.technion.ac.il/packages/smartlink/ungrab-winmodem.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="alsa usb"

RDEPEND="alsa? ( media-libs/alsa-lib )
	amd64? ( app-emulation/emul-linux-x86-soundlibs )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
S=${WORKDIR}/${P/_pre/-}

pkg_setup() {
	has_multilib_profile && ABI=x86

	MODULE_NAMES="ungrab-winmodem(:${WORKDIR}/ungrab-winmodem)"
	if ! use amd64; then
		MODULE_NAMES="${MODULE_NAMES} slamr(net:${S}/drivers)"
		if use usb; then
			MODULE_NAMES="${MODULE_NAMES} slusb(net:${S}/drivers)"
			CONFIG_CHECK="USB"
		fi
	fi
	BUILD_TARGETS="all"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	sed -i "s:SUBDIRS=\$(shell pwd):SUBDIRS=${WORKDIR}/ungrab-winmodem:" \
		"${WORKDIR}/ungrab-winmodem/Makefile"
	convert_to_m "${WORKDIR}/ungrab-winmodem/Makefile"

	cd "${S}"
	epatch "${FILESDIR}/${P%%_*}-modem-makefile.patch"
	cd drivers
	sed -i "s:SUBDIRS=\$(shell pwd):SUBDIRS=${S}/drivers:" Makefile
	convert_to_m Makefile
	sed -i "s:.*=[ \t]*THIS_MODULE.*::" st7554.c amrmo_init.c old_st7554.c
	sed -i 's:MODULE_PARM(\([^,]*\),"i");:module_param(\1, int, 0);:' st7554.c \
		amrmo_init.c old_st7554.c
}

src_compile() {
	local MAKE_PARAMS=""
	if use alsa || use amd64; then
		MAKE_PARAMS="SUPPORT_ALSA=1"
	fi
	emake ${MAKE_PARAMS} modem || die "failed to build modem"

	has_multilib_profile && ABI=${DEFAULT_ABI}
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	cd "${S}"
	newsbin modem/modem_test slmodem_test
	dosbin modem/slmodemd
	dodir /var/lib/slmodem
	fowners root:dialout /var/lib/slmodem
	keepdir /var/lib/slmodem

	newconfd "${FILESDIR}/${PN}-2.9.conf" ${PN}
	newinitd "${FILESDIR}/${PN}-2.9.11.init" ${PN}

	# configure for alsa - or not for alsa
	if use alsa; then
		sed -i -e "s/# MODULE=alsa/MODULE=alsa/" \
			-e "s/# HW_SLOT=modem:1/HW_SLOT=modem:1/" "${D}/etc/conf.d/slmodem"
	else
		sed -i "s/# MODULE=slamr/MODULE=slamr/" "${D}/etc/conf.d/slmodem"
	fi


	# Add module aliases and install hotplug script
	insinto /etc/modules.d/; newins "${FILESDIR}/${PN}-2.9.11.modules" ${PN}
	if use usb; then
		exeinto /etc/hotplug/usb; newexe "${FILESDIR}/slusb.hotplug" slusb
	fi

	dodir /etc/hotplug/blacklist.d
	echo -e "slusb\nslamr\nsnd-intel8x0m" >> "${D}/etc/hotplug/blacklist.d/${PN}"

	# Add configuration for devfs, udev
	if [ -e "${ROOT}/dev/.devfsd" ] ; then
		insinto /etc/devfs.d/; newins "${FILESDIR}/${PN}-2.9.devfs" ${PN}
	elif [ -e "${ROOT}/dev/.udev" ] ; then
		dodir /etc/udev/rules.d/
		echo 'KERNEL="slamr", NAME="slamr0" GROUP="dialout"' > \
			 "${D}/etc/udev/rules.d/55-${PN}.rules"
		echo 'KERNEL="slusb", NAME="slusb0" GROUP="dialout"' >> \
			 "${D}/etc/udev/rules.d/55-${PN}.rules"
	fi

	dodoc Changes README "${WORKDIR}/ungrab-winmodem/Readme.txt"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	# Make some devices if we aren't using devfs or udev
	if [ -e "${ROOT}/dev/.devfsd" ]; then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend $?

	elif [ -e "${ROOT}/dev/.udev" ]; then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend $?
	else
		cd "${S}/drivers"
		make DESTDIR="${ROOT}" install-devices
	fi

	if [ ! -e "${ROOT}/dev/ppp" ]; then
		mknod "${ROOT}/dev/ppp" c 108 0
	fi

	ewarn "To avoid problems, slusb/slamr have been added to /etc/hotplug/blacklist"
	einfo "You must edit /etc/conf.d/${PN} for your configuration"
	einfo "To add slmodem to your startup - type : rc-update add slmodem default"

	if use alsa; then
		einfo "I hope you have already added alsa to your startup: "
		einfo "otherwise type: rc-update add alsasound boot"
		einfo
		einfo "If you need to use snd-intel8x0m from the kernel"
		einfo "compile it as a module and edit /etc/modules.d/alsa"
		einfo 'to: "alias snd-card-(number) snd-intel8x0m"'
	fi

	einfo "You need to be in the uucp AND dialout group to make calls as a user."
	einfo
	einfo "If you see the following in dmesg:"
	echo slamr: device 10b9:5457 is grabbed by driver serial
	einfo "you need to modprobe ungrab-winmodem before slamr"
}
