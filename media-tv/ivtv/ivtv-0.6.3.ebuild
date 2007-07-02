# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.6.3.ebuild,v 1.7 2007/07/02 15:20:29 peper Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"

FW_VER_DEC="pvr_1.18.21.22254_inf.zip"
FW_VER_ENC="pvr_2.0.24.23035.zip"
#Switched to recommended firmware by driver

SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/0.6.x/${P}.tar.gz
	ftp://ftp.shspvr.com/download/wintv-pvr_150-500/inf/${FW_VER_ENC}
	ftp://ftp.shspvr.com/download/wintv-pvr_250-350/inf/${FW_VER_DEC}"

RESTRICT="mirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"

IUSE=""

BUILD_TARGETS="all"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"
CONFIG_CHECK="I2C_ALGOBIT VIDEO_DEV I2C_CHARDEV I2C"

RDEPEND="|| ( >=sys-fs/udev-103 sys-apps/hotplug )"
DEPEND="app-arch/unzip"

pkg_setup() {

	if ! kernel_is 2 6 16; then
		eerror "Each IVTV driver branch will only work with a specific"
		eerror "linux kernel branch."
		eerror ""
		eerror "You will need to either:"
		eerror "a) emerge a different kernel"
		eerror "b) emerge a different driver"
		eerror ""
		eerror "ivtv branch <--> kernel branch"
		eerror "0.8.x <--> 2.6.18.x"
		eerror "0.7.x <--> 2.6.17.x"
		eerror "0.6.x <--> 2.6.16.x"
		eerror "0.4.x <--> 2.6.15.x"
		eerror ""
		eerror "See http://ivtvdriver.org/ for more information"
		echo ""
		die "This only works on 2.6.16 kernels"
	fi

	linux-mod_pkg_setup
	MODULE_NAMES="ivtv(extra:${S}/driver)"
	CONFIG_CHECK="${CONFIG_CHECK} VIDEO_DECODER VIDEO_AUDIO_DECODER VIDEO_BT848"

	linux_chkconfig_present FB && \
	MODULE_NAMES="${MODULE_NAMES} ivtv-fb(extra:${S}/driver)"

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${P}.tar.gz
	unpack ${FW_VER_ENC}

	cd ${S}
	sed -e "s:^VERS26=.*:VERS26=${KV_MAJOR}.${KV_MINOR}:g" \
		-i ${S}/driver/Makefile || die "sed failed"
}

src_compile() {
	cd ${S}/driver
	linux-mod_src_compile || die "failed to build driver "

	cd ${S}/utils
	emake ||  die "failed to build utils "
}

src_install() {
	cd ${S}/utils
	dodir /lib/firmware
	./ivtvfwextract.pl "${DISTDIR}"/${FW_VER_DEC} \
		"${D}"/lib/firmware/v4l-cx2341x-enc.fw \
		"${D}"/lib/firmware/v4l-cx2341x-dec.fw

	make KERNELDIR="${KERNEL_DIR}" DESTDIR="${D}" PREFIX=/usr install || die "failed to install"

	insinto /lib/firmware
	newins "${WORKDIR}"/HcwMakoA.ROM v4l-cx25840.fw
	newins ${S}/v4l-cx2341x-init.mpg v4l-cx2341x-init.mpg

	cd ${S}
	dodoc README doc/* utils/README.X11

	cd ${S}/driver
	linux-mod_src_install || die "failed to install modules"

	# Add the aliases
	insinto /etc/modules.d
	newins "${FILESDIR}"/ivtv ivtv
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
	BADMODS="msp3400 tda9887 tuner tveeprom"

	if [ ${KV_PATCH} -le 14 ]; then
		for MODNAME in ${BADMODS}; do
			if [ -f "${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/${MODNAME}.ko" ] ; then
				ewarn "You have the ${MODNAME} module that comes with the kernel. It isn't compatible"
				ewarn "with ivtv. You need to back it up to somewhere else, then run 'update-modules'"
				ewarn "The file to remove is ${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/${MODNAME}.ko"
				echo
			fi
		done
	fi
}
