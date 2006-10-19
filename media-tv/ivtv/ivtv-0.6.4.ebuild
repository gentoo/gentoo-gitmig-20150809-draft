# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.6.4.ebuild,v 1.2 2006/10/19 23:34:26 cardoe Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/0.6.x/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

BUILD_TARGETS="all"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"
CONFIG_CHECK="I2C_ALGOBIT VIDEO_DEV I2C_CHARDEV I2C"

RDEPEND="sys-apps/hotplug"
DEPEND="app-arch/unzip"
PDEPEND="media-tv/pvr-firmware"

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="ivtv(extra:${S}/driver)"

	if kernel_is 2 6 16; then
		CONFIG_CHECK="${CONFIG_CHECK} VIDEO_DECODER VIDEO_AUDIO_DECODER VIDEO_BT848"
	else
		die "This only works on 2.6.16 kernels"
	fi

	linux_chkconfig_present FB && \
	MODULE_NAMES="${MODULE_NAMES} ivtv-fb(extra:${S}/driver)"

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
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
	make KERNELDIR="${KERNEL_DIR}" DESTDIR="${D}" PREFIX=/usr install \
		|| die "failed to install utils"

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
				ewarn "with ivtv. You need to back it up to somewhere else, then run 'modules-update'"
				ewarn "The file to remove is ${ROOT}/lib/modules/${KV_FULL}/kernel/drivers/media/video/${MODNAME}.ko"
				echo
			fi
		done
	fi
}
