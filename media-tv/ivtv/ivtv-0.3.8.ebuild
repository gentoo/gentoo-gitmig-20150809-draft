# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.3.8.ebuild,v 1.1 2005/09/15 05:53:56 cardoe Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"

FW_VER="pvr_1.18.21.22168_inf.zip"

SRC_URI="http://dl.ivtvdriver.org/${PN}/${P}.tar.gz
	ftp://ftp.shspvr.com/download/wintv-pvr_250-350/inf/${FW_VER}"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
S="${WORKDIR}/${P}"

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
}

src_unpack() {
	unpack ${P}.tar.gz

	sed -e "s:^VERS26=.*:VERS26=${KV_MAJOR}.${KV_MINOR}:g" \
		-i ${S}/driver/Makefile || die "sed failed"

	# This powerpc patch patches the source of the driver to disable DMA on ppc,
	# instead PIO is used. Also, it force enables -fsigned-char and does not
	# build some modules that contain x86 asm.

	use ppc && epatch ${FILESDIR}/ppc-odw.patch || die "ppc patch failed"
}

src_compile() {
	cd ${S}/driver
	linux-mod_src_compile || die "failed to build driver "

	cd ${S}/utils
	emake ||  die "failed to build utils "
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
	make KERNELDIR=${KERNEL_DIR} DESTDIR=${D} INSTALLDIR=/usr/bin install || die "failed to install"

	cd ${S}/driver
	linux-mod_src_install || die "failed to install modules"

	# Add the aliases
	insinto /etc/modules.d
	newins ${FILESDIR}/ivtv ivtv
}

pkg_postinst() {
	linux-mod_pkg_postinst

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
