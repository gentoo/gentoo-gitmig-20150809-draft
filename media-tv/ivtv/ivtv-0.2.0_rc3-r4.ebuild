# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.2.0_rc3-r4.ebuild,v 1.1 2005/04/26 23:32:20 iggy Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR[23]50 cards"
HOMEPAGE="http://205.209.168.201/~ckennedy/ivtv/"

MY_P="${P/_/-}j"
FW_VER="pvr_1.18.21.22168_inf.zip"

SRC_URI="http://www.ivtv.tv/releases/ivtv-0.2/${MY_P}.tgz
	ftp://ftp.shspvr.com/download/wintv-pvr_250-350/inf/${FW_VER}"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE=""
S="${WORKDIR}/${MY_P}"

BUILD_TARGETS="all"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"
CONFIG_CHECK="I2C_ALGOBIT VIDEO_DEV"

DEPEND="app-arch/unzip"

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="ivtv(extra:${S}/driver)
		msp3400(extra:${S}/driver)
		saa7115(extra:${S}/driver)
		tveeprom(extra:${S}/driver)
		saa7127(extra:${S}/driver)"
	linux_chkconfig_present FB && MODULE_NAMES="${MODULE_NAMES} ivtv-fb(extra:${S}/driver)" && einfo "Enabling ivtv-fb support"
}

src_unpack() {
	unpack ${MY_P}.tgz

	sed -e "s:^VERS26=.*:VERS26=${KV_MAJOR}.${KV_MINOR}:g" \
		-i ${S}/driver/Makefile || die "sed failed"
	sed -e "s:^KERNVER = .*:KERNVER = ${KV_FULL}:g" \
		-i ${S}/driver/Makefile2.* || die "sed failed"

	convert_to_m ${S}/driver/Makefile2.6
}

src_compile() {
	cd ${S}/driver
	linux-mod_src_compile || die "failed to build kernel modules"

	cd ${S}/utils
	# the Makefile uses KERNELDIR only to find the .config, so we use KV_OUT_DIR
	make KERNELDIR=${KV_OUT_DIR} ||  die "build of utils failed"
}

src_install() {
	cd ${S}/utils
	dodir /lib/modules
	./ivtvfwextract.pl ${DISTDIR}/${FW_VER} \
		${D}/lib/modules/ivtv-fw-enc.bin \
		${D}/lib/modules/ivtv-fw-dec.bin

	cd ${S}
	dodoc README doc/*
	cd ${S}/utils
	newdoc README README.utils
	dodoc README.mythtv-ivtv README.X11
	dodoc lircd-g.conf lircd.conf lircrc

	cd ${S}/utils
	#should work... no idea why its not
	#make KERNELDIR=${KERNEL_DIR} DESTDIR=${D} INSTALLDIR=/usr/bin install-sane || die "failed to install"
	newbin encoder ivtv-encoder
	newbin fwapi ivtv-fwapi
	newbin radio ivtv-radio
	newbin vbi ivtv-vbi
	newbin mpegindex ivtv-mpegindex
	dobin ivtvfbctl ivtvplay ivtvctl

	cd ${S}/driver
	linux-mod_src_install || die "failed to install modules"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "You now have the driver for the Hauppauge PVR-[23]50 cards."
	einfo "Add ivtv to /etc/modules.autoload.d/kernel-2.X"
	echo
	einfo "To get the ir remote working, you'll need to emerge lirc"
	einfo "with the following set:"
	einfo "LIRC_OPTS=\"--with-x --with-driver=hauppauge --with-major=61 "
	einfo "	--with-port=none --with-irq=none\" emerge lirc"
	echo
	einfo "You can also add the above LIRC_OPTS line to /etc/make.conf for"
	einfo "it to remain there for future updates."
	echo
	einfo "To use vbi, you'll need a few other things, check README.vbi in the docs dir"
	echo
	einfo "The ptune* scripts have moved to media-tv/ivtv-ptune, emerge that to use those scripts"
	echo

	if [ -f "${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/msp3400.ko" ] ; then
		ewarn "You have the msp3400 module that comes with the kernel. It isn't compatible"
		ewarn "with ivtv. You need to back it up to somewhere else, then run update-modules"
	fi
}
