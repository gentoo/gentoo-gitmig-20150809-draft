# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-dvb-hg/v4l-dvb-hg-0.1-r4.ebuild,v 1.4 2012/04/13 19:36:13 ulm Exp $

EAPI=2

: ${EHG_REPO_URI:=${V4L_DVB_HG_REPO_URI:-http://linuxtv.org/hg/v4l-dvb}}

inherit linux-mod eutils toolchain-funcs mercurial savedconfig

DESCRIPTION="Live development version of V4L and DVB driver for kernel 2.6"
SRC_URI=""
HOMEPAGE="http://www.linuxtv.org"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

S="${WORKDIR}/v4l"

CONFIG_CHECK="!DVB_CORE !VIDEO_DEV"

pkg_setup()
{
	linux-mod_pkg_setup
	if ! kernel_is -ge 2 6; then
		ewarn "other Kernel than 2.6.x are not supported at the moment."
		die "unsupported Kernel (not 2.6.x)"
	fi
	MODULE_NAMES="dvb(dvb:${S})"
	BUILD_PARAMS="KDIR=${KERNEL_DIR}"
	BUILD_TARGETS="default"

	if [[ -d ${ROOT}/lib/modules/${KV_FULL}/v4l-dvb-cvs ]]; then
		ewarn "There are stale dvb-modules from the ebuild v4l-dvb-cvs."
		ewarn "Please remove the directory /lib/modules/${KV_FULL}/v4l-dvb-cvs"
		ewarn "with all its files and subdirectories and then restart emerge."
		ewarn
		ewarn "# rm -rf /lib/modules/${KV_FULL}/v4l-dvb-cvs"
		die "Stale dvb-modules found, restart merge after removing them."
	fi
}

src_prepare() {

	einfo "Removing modules-install"
	sed -i "${S}"/v4l/Makefile -e "s/media-install firmware_install/media-install/"

	# apply local patches
	if test -n "${DVB_LOCAL_PATCHES}";
	then
		ewarn "Applying local patches:"
		for LOCALPATCH in ${DVB_LOCAL_PATCHES};
		do
			if test -f "${LOCALPATCH}";
			then
				if grep -q linux/drivers "${LOCALPATCH}"; then
					cd "${S}"/..
				else
					cd "${S}"
				fi
				epatch "${LOCALPATCH}"
			fi
		done
	else
		einfo "No additional local patches to use"
	fi

	export ARCH=$(tc-arch-kernel)
	make allmodconfig ${BUILD_PARAMS}
	export ARCH=$(tc-arch)

	echo

	elog "Removing autoload-entry from stradis-driver."
	sed -e "${S}"/linux/drivers/media/video/stradis.c -i '/MODULE_DEVICE_TABLE/d'

	cd "${S}/v4l"
	sed	-e '/-install::/s:rminstall::' \
		-i Makefile

	elog "Removing depmod-calls"
	sed -e '/depmod/d' -i Makefile* scripts/make_makefile.pl scripts/make_kconfig.pl \
	|| die "Failed removing depmod call from Makefile"

	grep depmod * && die "Not removed depmod found."

	mkdir "${WORKDIR}"/header
	cd "${WORKDIR}"/header
	cp "${S}"/linux/include/linux/dvb/* .
	sed -e '/compiler/d' \
		-e 's/__user//' \
		-i *.h

	cd "${S}/v4l"
	restore_config .config
}

src_install() {
	# install the modules
	local DEST="${D}/lib/modules/${KV_FULL}/v4l-dvb"
	make install \
		DEST="${DEST}" \
		KDIR26="${DEST}" \
		KDIRA="${DEST}" \
	|| die "make install failed"

	cd "${S}"
	dodoc linux/Documentation/dvb/*.txt
	dosbin linux/Documentation/dvb/get_dvb_firmware

	insinto /usr/include/v4l-dvb-hg/linux/dvb
	cd "${WORKDIR}/header"
	doins *.h

	cd "${S}/v4l"
	save_config .config
}

pkg_postinst() {
	echo
	elog "Firmware-files can be found in media-tv/linuxtv-dvb-firmware"
	echo

	linux-mod_pkg_postinst
	echo
	echo
	elog "if you want to use the IR-port or networking"
	elog "with the dvb-card you need to"
	elog "install linuxtv-dvb-apps"
	echo
}
