# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fobbit/fobbit-0.56.ebuild,v 1.4 2004/03/27 02:55:07 eradicator Exp $

MY_P="${PN}-0.60rc1"
S="${WORKDIR}/${MY_P}/src"
DESCRIPTION="Software to use the Creative VoiceBlaster USB VoIP phone device"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.fobbit.org/ http://www.sourceforge.net/projects/fobbit/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

IUSE=""

src_compile() {
	check_KV
	einfo "Building vb client"
	cd ${S}
	sh TOUNIX
	make
	einfo "Building kernel module"

	cd ${S}/linux_drv/

	# the linux driver for kernel series 2.4.20 is different than for
	# earlier kernels, so we have to detect the kernel version and
	# manually select the source file.

	# snippet courtesy of media-video/nvidia-kernel
	# Get the kernel version of sources in /usr/src/linux ...
	local KV_full="$(awk '/UTS_RELEASE/ { gsub("\"", "", $3); print $3 }' \
		"${ROOT}/usr/src/linux/include/linux/version.h")"
	local KV_major="$(echo "${KV_full}" | cut -d. -f1)"
	local KV_minor="$(echo "${KV_full}" | cut -d. -f2)"
	local KV_micro="$(echo "${KV_full}" | cut -d. -f3 | sed -e 's:[^0-9].*::')"
	einfo "Linux kernel ${KV_major}.${KV_minor}.${KV_micro}"

	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 4 ] && \
		[ "${KV_micro}" -ge 20 ]
	then
		einfo "Using 2.4.20 usbvb source file"
		mv usbvb.c usbvb_old.c
		mv usbvb-2.4.20.c usbvb.c
	fi

	make
}

src_install() {
	cd ${S}
	# make the /usr/bin/vb binary
	newbin vb vb
	# place the kernel module somewhere nice
	dodir /lib/modules/${KV}/misc
	insinto /lib/modules/${KV}/misc
	doins linux_drv/usbvb.o
}

pkg_config() {
	# make devs is a seperate step, because it needn't be repeated for
	# re-installs, etc..
	mknod /dev/usb/vbc0 c 180 200
	mknod /dev/usb/vbc1 c 180 201
	mknod /dev/usb/vbc2 c 180 202
	mknod /dev/usb/vbc3 c 180 203
	mknod /dev/usb/vbv0 c 180 204
	mknod /dev/usb/vbv1 c 180 205
	mknod /dev/usb/vbv2 c 180 206
	mknod /dev/usb/vbv3 c 180 207
}

pkg_postinst() {
	einfo ""
	einfo "Execute:"
	einfo ""
	einfo " \"ebuild /var/db/pkg/media-sound/${P}/${P}.ebuild config\""
	einfo ""
	einfo "to create the USB VB devices in /dev/vbc[0-3] and /dev/vbv[0-3]."
	einfo ""
	einfo "To load the usbvb module, you may type \"insmod usbvb\". To have"
	einfo "the module load automatically at boot time, add the line \"usbvb\""
	einfo "to /etc/modules.autoload"
	einfo ""
}

