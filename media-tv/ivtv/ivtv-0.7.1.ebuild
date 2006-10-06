# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-0.7.1.ebuild,v 1.1 2006/10/06 00:09:27 cardoe Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/0.7.x/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

BUILD_TARGETS="all"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"

RDEPEND="sys-apps/hotplug"
DEPEND="app-arch/unzip"
PDEPEND="media-tv/pvr-firmware"

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="ivtv(extra:${S}/driver) \
			saa717x(extra:${S}/i2c-drivers)"

	if kernel_is 2 6 17; then
		CONFIG_CHECK="EXPERIMENTAL VIDEO_DEV I2C VIDEO_V4L1 VIDEO_V4L2 FW_LOADER"
		CONFIG_CHECK="${CONFIG_CHECK} VIDEO_WM8775 VIDEO_MSP3400 VIDEO_CX25840 VIDEO_TUNER"
		CONFIG_CHECK="${CONFIG_CHECK} VIDEO_SAA711X VIDEO_SAA7127 VIDEO_TVEEPROM"
	else
		die "This only works on 2.6.17 kernels"
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
