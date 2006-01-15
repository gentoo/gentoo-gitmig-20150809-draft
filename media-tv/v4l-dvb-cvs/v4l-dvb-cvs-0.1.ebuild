# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-dvb-cvs/v4l-dvb-cvs-0.1.ebuild,v 1.2 2006/01/15 13:10:13 zzam Exp $


inherit linux-mod eutils toolchain-funcs

ECVS_ANON="yes"
ECVS_CVS_OPTIONS="-dP"
: ${ECVS_SERVER:=cvs.linuxtv.org:/cvs/video4linux}
ECVS_MODULE="v4l-dvb"
ECVS_BRANCH="HEAD"

S="${WORKDIR}/${ECVS_MODULE}/v4l"

inherit cvs

DESCRIPTION="CVS-Version of v4l&dvb-driver for Kernel 2.6"
SRC_URI=""
HOMEPAGE="http://www.linuxtv.org"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""

pkg_setup()
{
	linux-mod_pkg_setup
	if [[ "${KV_MAJOR}.${KV_MINOR}" != "2.6"  ]]; then
		ewarn "other Kernel than 2.6.x are not supported at the moment."
		die "unsupported Kernel (not 2.6.x)"
	fi
	MODULE_NAMES="dvb(dvb:${S})"
	BUILD_PARAMS="KDIR=${KERNEL_DIR}"
	BUILD_TARGETS="default"
}

src_unpack() {
	# download and copy files
	cvs_src_unpack

	MY_MAKE_OPTS="KDIR=${KV_DIR}"

	cd ${S}
	export ARCH=$(tc-arch-kernel)
	make links ${MY_MAKE_OPTS} >/dev/null
	export ARCH=$(tc-arch)

	# apply local patches
	if test -n "${DVB_LOCAL_PATCHES}";
	then
		ewarn "Applying local patches:"
		for LOCALPATCH in ${DVB_LOCAL_PATCHES};
		do
			if test -f "${LOCALPATCH}";
			then
				if grep -q linux/drivers ${LOCALPATCH}; then
					cd ${S}/..
				else
					cd ${S}
				fi
				epatch ${LOCALPATCH}
			fi
		done
	else
		einfo "No additional local patches to use"
	fi
	echo

	cd ${S}
	sed -e 's#/lib/modules/$(KERNELRELEASE)/kernel/drivers/media#$(DESTDIR)/$(DEST)#' \
		-e '/depmod/d' \
		-e 's#-install:: .*-rminstall#-install::#' \
		-i.orig Makefile
}

src_install() {
	# install the modules
	make {v4l,dvb}-install DESTDIR="${D}" \
		DEST="/lib/modules/${KV_FULL}/${PN}" \
		KERNELRELEASE=${KV_FULL} SUBLEVEL=${KV_PATCH} PATCHLEVEL=${KV_MINOR} \
	|| die "make install failed"

	cd ${S}/..
	dodoc linux/Documentation/dvb/*.txt
	dosbin linux/Documentation/dvb/get_dvb_firmware
}

pkg_postinst() {
	einfo
	einfo "Firmware-files can be found in media-tv/linuxtv-dvb-firmware"
	einfo

	linux-mod_pkg_postinst
	einfo
	einfo
	einfo "if you want to use the IR-port or networking"
	einfo "with the dvb-card you need to"
	einfo "install dvb-apps"
	einfo
}
