# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.4.0-r3.ebuild,v 1.1 2005/12/30 05:03:53 cardoe Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"

FW_VER_DEC="pvr_1.18.21.22254_inf.zip"
FW_VER_ENC="pvr_2.0.24.23035.zip"
#Switched to recommended firmware by driver

SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/0.4.x/${P}.tar.gz
	ftp://ftp.shspvr.com/download/wintv-pvr_150-500/inf/${FW_VER_ENC}
	ftp://ftp.shspvr.com/download/wintv-pvr_250-350/inf/${FW_VER_DEC}"

RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86 ppc"

IUSE=""

BUILD_TARGETS="all"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"
CONFIG_CHECK="I2C_ALGOBIT VIDEO_DEV I2C_CHARDEV I2C"

DEPEND="app-arch/unzip"

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="ivtv(extra:${S}/driver)
		msp3400(extra:${S}/driver)
		saa7115(extra:${S}/driver)
		tveeprom(extra:${S}/driver)
		saa7127(extra:${S}/driver)
		cx25840(extra:${S}/driver)
		tuner(extra:${S}/driver)
		wm8775(extra:${S}/driver)
		tda9887(extra:${S}/driver)
		cs53l32a(extra:${S}/driver)"
	linux_chkconfig_present FB && \
	MODULE_NAMES="${MODULE_NAMES} ivtv-fb(extra:${S}/driver)"
}

src_unpack() {
	unpack ${P}.tar.gz
	unpack ${FW_VER_ENC}

	sed -e "s:^VERS26=.*:VERS26=${KV_MAJOR}.${KV_MINOR}:g" \
		-i "${S}"/driver/Makefile || die "sed failed"

	cd "${S}"
	# This powerpc patch patches the source of the driver to disable DMA on ppc,
	# instead PIO is used. Also, it force enables -fsigned-char and does not
	# build some modules that contain x86 asm.

	use ppc && epatch "${FILESDIR}"/${P}-ppc-odw.patch

	# patch to make it stop seg faulting because it uses wrong MAXDEV size
	epatch "${FILESDIR}"/${P}-maxdev.patch
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
	./ivtvfwextract.pl ${DISTDIR}/${FW_VER_DEC} \
		${D}/lib/modules/ivtv-fw-enc.bin \
		${D}/lib/modules/ivtv-fw-dec.bin

	make KERNELDIR=${KERNEL_DIR} DESTDIR="${D}" PREFIX=/usr install || die "failed to install"

	insinto /lib/modules
	newins ${WORKDIR}/HcwMakoA.ROM HcwMakoA.ROM
	newins ${S}/ivtv_init_mpeg.bin ivtv_init_mpeg.bin

	cd ${S}
	dodoc README doc/* utils/README.X11

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

	# Similar checks are performed by the make install in the drivers directory.
	BADMODS="msp3400 tda9887 tuner tveeprom saa7115 saa7127 cx25840 wm8775"

	for MODNAME in ${BADMODS}; do
		if [ -f "${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/${MODNAME}.ko" ] ; then
			ewarn "You have the ${MODNAME} module that comes with the kernel. It isn't compatible"
			ewarn "with ivtv. You need to back it up to somewhere else, then run 'update-modules'"
			ewarn "The file to remove is ${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/${MODNAME}.ko"
			echo
		fi
	done
}
