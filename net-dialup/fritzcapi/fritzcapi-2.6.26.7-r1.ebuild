# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fritzcapi/fritzcapi-2.6.26.7-r1.ebuild,v 1.1 2004/11/28 10:16:48 mrness Exp $

inherit kernel-mod rpm

S="${WORKDIR}/usr/src/kernel-modules/fritzcapi"

DESCRIPTION="SuSE's 2.6 AVM kernel modules for fcclassic, fcpci, fcpcmcia, fcpnp, fcusb, fcusb2, fxusb_CZ and fxusb"
HOMEPAGE="http://www.avm.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/update/9.1/rpm/i586/km_${P/2.6./2.6-}.i586.rpm"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcmcia usb"

RDEPEND=">=net-dialup/capi4k-utils-20040810"
DEPEND="${RDEPEND}
	virtual/linux-sources"

FRITZCAPI_MODULES=("fcclassic" "fcpci" "fcpcmcia" "fcpnp" "fcusb" "fcusb2" "fxusb_CZ" "fxusb")
FRITZCAPI_TARGETS=("fritz.classic" "fritz.pci" "fritz.pcmcia" "fritz.pnp" "fritz.usb" "fritz.usb2" "fritz.xusb_CZ" "fritz.xusb")

pkg_setup() {
	if ! kernel-mod_is_2_6_kernel; then
		die "This package works only with 2.6 kernel!"
	fi
	if ! kernel-mod_configoption_present ISDN_CAPI_CAPI20; then
		die "For using the driver you need a kernel with enabled CAPI support."
	fi
	kernel-mod_check_modules_supported

	local USERCARD CARD
	FRITZCAPI_BUILD_TARGETS=""
	if [ -n "${FRITZCAPI_CARDS}" ]; then
		#Check existence of user selected cards
		for USERCARD in ${FRITZCAPI_CARDS} ; do
			for ((CARD=0; CARD < ${#FRITZCAPI_MODULES[*]}; CARD++)); do
				if [ "$USERCARD" = "${FRITZCAPI_MODULES[CARD]}" ]; then
					FRITZCAPI_BUILD_TARGETS="${FRITZCAPI_BUILD_TARGETS} ${FRITZCAPI_TARGETS[CARD]}"
					continue 2
				fi
			done
			die "Module ${USERCARD} not present in ${P}"
		done
	else
		#Filter build targets by USE
		for ((CARD=0; CARD < ${#FRITZCAPI_MODULES[*]}; CARD++)); do
			if [ ${FRITZCAPI_MODULES[CARD]/pcmcia/} != ${FRITZCAPI_MODULES[CARD]} ] && ! useq pcmcia; then
				continue
			fi
			if [ ${FRITZCAPI_MODULES[CARD]/usb/} != ${FRITZCAPI_MODULES[CARD]} ] && ! useq usb; then
				continue
			fi
			FRITZCAPI_BUILD_TARGETS="${FRITZCAPI_BUILD_TARGETS} ${FRITZCAPI_TARGETS[CARD]}"
		done
	fi
}

src_unpack() {
	rpm_src_unpack ${A} || die "Could not unpack RPM package."
}

src_compile() {
	(
		unset ARCH
		emake KERNEL_SOURCE="${ROOT}/usr/src/linux" TARGETS="${FRITZCAPI_BUILD_TARGETS}" modules || \
			die "emake modules failed"
	)
}

src_install() {
	insinto /lib/modules/${KV_VERSION_FULL}/extra
	doins fritz.*/src/*.ko
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
