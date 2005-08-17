# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.3.7c.ebuild,v 1.3 2005/08/17 05:30:29 mr_bones_ Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://ivtv.writeme.ch"

MY_P="${P/_/-}"
FW_VER="pvr_1.18.21.22168_inf.zip"

SRC_URI="http://www.ivtv.tv/releases/ivtv-0.3/${MY_P}.tgz
	ftp://ftp.shspvr.com/download/wintv-pvr_250-350/inf/${FW_VER}"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"
# THIS EBUILD IS FOR DEVELOPMENT PURPOSES ONLY. IT IS UNSUPPORTED

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
		saa7127(extra:${S}/driver)
		cx25840(extra:${S}/driver)"
	linux_chkconfig_present FB && MODULE_NAMES="${MODULE_NAMES}"

	einfo "Unsupported development ebuild"
}

src_unpack() {
	unpack ${MY_P}.tgz

	sed -e "s:^VERS26=.*:VERS26=${KV_MAJOR}.${KV_MINOR}:g" \
		-i ${S}/driver/Makefile || die "sed failed"

	sed -e "s:^KERNVER = .*:KERNVER = ${KV_FULL}:g" \
		-i ${S}/driver/Makefile2.* || die "sed failed"

	# This powerpc patch patches the source of the driver to disable DMA on ppc,
	# instead PIO is used. Also, it force enables -fsigned-char and does not
	# build some modules that contain x86 asm.

	use ppc && epatch ${FILESDIR}/ppc-odw.patch

	convert_to_m ${S}/driver/Makefile2.6
}

src_compile() {
	cd ${S}/driver
	linux-mod_src_compile || die "failed to build driver "

	cd ${S}/utils
	make KERNELDIR=${KV_OUT_DIR} ||  die "failed to build utils "
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
	newbin fwapi ivtv-fwapi
	newbin radio ivtv-radio
	dobin ivtvctl

	cd ${S}/driver
	linux-mod_src_install || die "failed to install modules"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "You now have a driver for the Hauppauge PVR PCI cards."
	echo
	einfo "In general, the following instructions suffice to conclude the"
	einfo "installation. For more detailed instructions, please refer to the"
	einfo "ivtv wiki listed as the home page of this ebuild."
	echo
	einfo "1) Ignore the above commands, only add 'ivtv' to /etc/modules.autoload.d/kernel-2.X"
	echo
	einfo "2) Also add a files called 'ivtv' to /etc/modules.d which contains"
	einfo "   the two lines:"
	einfo "     alias char-major-81 videodev"
	einfo "     alias char-major-81-0 ivtv"
	echo
	einfo "3) Then perform a 'update-modules'."
	echo
	# The MCE versions of the PVR cards come without remote control because (I
	# assume) a remote control is included in Windows Media Center Edition. It
	# is probably a good idea to just say that if your package comes with a
	# remote then emerge lirc. Lirc should build all drivers anyway.
	#
	# einfo "To get the ir remote working, you'll need to emerge lirc"
	# einfo "with the following set:"
	# einfo "LIRC_OPTS=\"--with-x --with-driver=hauppauge --with-major=61 "
	# einfo "	--with-port=none --with-irq=none\" emerge lirc"
	# echo
	# einfo "You can also add the above LIRC_OPTS line to /etc/make.conf for"
	# einfo "it to remain there for future updates."
	# echo
	# einfo "To use vbi, you'll need a few other things, check README.vbi in the docs dir"
	# echo

	einfo "The ptune* scripts have moved to media-tv/ivtv-ptune, emerge that to use those scripts"
	echo

	# Similar checks are performed by the make install in the drivers directory.

	if [ -f "${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/msp3400.ko" ] ; then
		ewarn "You have the msp3400 module that comes with the kernel. It isn't compatible"
		ewarn "with ivtv. You need to back it up to somewhere else, then run 'update-modules'"
	fi
}
