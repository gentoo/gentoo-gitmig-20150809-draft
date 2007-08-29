# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fritzcapi/fritzcapi-2.6.43.ebuild,v 1.16 2007/08/29 18:45:40 genstef Exp $

inherit linux-mod rpm eutils

DESCRIPTION="SuSE's 2.6 AVM kernel modules for fcclassic, fcpci, fcpcmcia, fcpnp, fcusb, fcusb2, fxusb_CZ, fxusb, e2220pc and e5520pc"
HOMEPAGE="http://www.avm.de/"

SRC_URI="!amd64? ( ftp://ftp.suse.com/pub/suse/i386/10.1/SUSE-Linux10.1-Beta3-Extra/suse/i586/km_${P/2.6./2.6-}.i586.rpm )
	amd64? ( ftp://ftp.suse.com/pub/suse/i386/10.1/SUSE-Linux10.1-Beta3-Extra/suse/x86_64/km_${P/2.6./2.6-}.x86_64.rpm )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="pcmcia usb"

DEPEND="net-dialup/capi4k-utils"

S="${WORKDIR}/usr/src/kernel-modules/fritzcapi"

get_card_module_name() {
	local CARD=$1
	echo "${FRITZCAPI_MODULES[CARD]}(extra:${S}/${FRITZCAPI_TARGETS[CARD]}/src)"
	if [ "${FRITZCAPI_MODULES[CARD]/pcmcia/}" != ${FRITZCAPI_MODULES[CARD]} ]; then
		#PCMCIA have also a *_cs module
		echo "${FRITZCAPI_MODULES[CARD]}_cs(extra:${S}/${FRITZCAPI_TARGETS[CARD]}/src)"
	fi
}

pkg_setup() {
	linux-mod_pkg_setup
	if ! kernel_is 2 6; then
		die "This package works only with 2.6 kernel!"
	fi
	if ! linux_chkconfig_present ISDN_CAPI_CAPI20; then
		die "For using the driver you need a kernel with enabled CAPI support."
	fi

	local USERCARD CARD
	FRITZCAPI_BUILD_CARDS=""
	FRITZCAPI_BUILD_TARGETS=""
	MODULE_NAMES=""
	BUILD_PARAMS="KDIR='${KV_DIR}' LIBDIR='${WORKDIR}'/var/lib/fritz"
	BUILD_TARGETS="all"

	if ! use amd64; then
		FRITZCAPI_MODULES=("fcpci" "fcpcmcia" "fcusb" "fcusb2" "fxusb" "fcclassic"
			"fcpnp" "fxusb_CZ" "e2220pc" "e5520pc")
		FRITZCAPI_TARGETS=("fritz.pci" "fritz.pcmcia" "fritz.usb" "fritz.usb2"
			"fritz.xusb" "fritz.classic" "fritz.pnp" "fritz.xusb_CZ" "e2220pc" "e5520pc")
	else
		FRITZCAPI_MODULES=("fcpci" "fcpcmcia" "fcusb2")
		FRITZCAPI_TARGETS=("fritz.pci" "fritz.pcmcia" "fritz.usb2")
	fi

	if [ -n "${FRITZCAPI_CARDS}" ]; then
		#Check existence of user selected cards
		for USERCARD in ${FRITZCAPI_CARDS} ; do
			for ((CARD=0; CARD < ${#FRITZCAPI_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${FRITZCAPI_MODULES[CARD]}" ]; then
					FRITZCAPI_BUILD_CARDS="${FRITZCAPI_BUILD_CARDS} ${FRITZCAPI_MODULES[CARD]}"
					FRITZCAPI_BUILD_TARGETS="${FRITZCAPI_BUILD_TARGETS} ${FRITZCAPI_TARGETS[CARD]}"
					MODULE_NAMES="${MODULE_NAMES} `get_card_module_name ${CARD}`"
					continue 2
				fi
			done
			die "Module ${USERCARD} not present in ${P}"
		done
	else
		elog
		elog "You can control the modules which are built with the variable"
		elog "FRITZCAPI_CARDS which should contain a blank separated list"
		elog "of a selection from the following cards:"
		elog "   ${FRITZCAPI_MODULES[*]}"
		elog
		ewarn "I give you the chance of hitting Ctrl-C and make the necessary"
		ewarn "adjustments in /etc/make.conf."
		ebeep

		#Filter build targets by USE
		for ((CARD=0; CARD < ${#FRITZCAPI_MODULES[*]}; CARD++)); do
			if [ "${FRITZCAPI_MODULES[CARD]/pcmcia/}" != ${FRITZCAPI_MODULES[CARD]} ] && (! use pcmcia || kernel_is ge 2 6 17); then
				continue
			fi
			if [ "${FRITZCAPI_MODULES[CARD]/usb/}" != ${FRITZCAPI_MODULES[CARD]} ] && ! use usb; then
				continue
			fi
			FRITZCAPI_BUILD_CARDS="${FRITZCAPI_BUILD_CARDS} ${FRITZCAPI_MODULES[CARD]}"
			FRITZCAPI_BUILD_TARGETS="${FRITZCAPI_BUILD_TARGETS} ${FRITZCAPI_TARGETS[CARD]}"
			MODULE_NAMES="${MODULE_NAMES} `get_card_module_name ${CARD}`"
		done
	fi

	elog "Selected cards: ${FRITZCAPI_BUILD_CARDS}"
}

src_unpack() {
	rpm_unpack "${DISTDIR}/${A}" || die "failed to unpack ${A} file"

	cd "${S}"
	mkdir -p "${WORKDIR}/var/lib/fritz"
	ln fritz.*/lib/*-lib.o "${WORKDIR}/var/lib/fritz"
	for i in $(find . -name Makefile); do
		sed -i 's:-C \$(KDIR) SUBDIRS=:-C $(KDIR) $(if $(KBUILD_OUTPUT),O=$(KBUILD_OUTPUT)) SUBDIRS=:' ${i}
		sed -i 's:$(PWD)/../lib/$(CARD)-lib.o:$(LIBDIR)/$(CARD)-lib.o:' ${i}
		sed -i "s:@cp -f ../lib/\$(CARD)-lib.o \$(LIBDIR)::" ${i}
		sed -i "s:\$(PWD)/../lib/driver-lib.o:${S}/e2220pc/lib/driver-lib.o:" ${i}
		convert_to_m ${i}
	done
	if [ -e fritz.usb2 ]; then
		cd fritz.usb2; epatch ${FILESDIR}/fcusb2-2.6.19.patch; cd ..
	fi
	if ! use amd64; then
	  epatch ${FILESDIR}/2.6.43-linux-2.6.19-irq_handler.patch
	  kernel_is ge 2 6 17 && epatch ${FILESDIR}/2.6.43-fcpcmcia.patch
	  kernel_is ge 2 6 20 && epatch ${FILESDIR}/fritzcapi-2.6.20.patch
	  kernel_is ge 2 6 22 && epatch ${FILESDIR}/fritzcapi-2.6.22.patch
	else
	  epatch ${FILESDIR}/2.6.43-linux-2.6.19-irq_handler.amd64.patch
	  kernel_is ge 2 6 17 && epatch ${FILESDIR}/2.6.43-fcpcmcia.amd64.patch
	  kernel_is ge 2 6 20 && epatch ${FILESDIR}/fritzcapi-2.6.20.amd64.patch
	  kernel_is ge 2 6 22 && epatch ${FILESDIR}/2.6.43-linux-2.6.22-pci_module_init.patch
	fi
	find -name \*.[hc] -print0 | xargs -0 sed -i '
		s:#include <linux/config\.h>:#include <linux/autoconf.h>:;
		s/driver_init/fc_driver_init/g; s/driver_exit/fc_driver_exit/;'
}

src_install() {
	linux-mod_src_install

	keepdir /lib/firmware

	[ "${FRITZCAPI_BUILD_TARGETS/xusb_CZ/}" != "${FRITZCAPI_BUILD_TARGETS}" ] && \
		dodoc "${S}/fritz.xusb_CZ/README.fxusb_CZ"

	[ "${FRITZCAPI_BUILD_TARGETS/usb2/}" != "${FRITZCAPI_BUILD_TARGETS}" ] && (
		insinto /lib/firmware
		insopts -m0644
		doins "${S}"/fritz.usb2/*.frm
	)
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "If your device needs a firmware, you should edit copy the firmware files"
	elog "in /lib/firmware and edit /etc/capi.conf."
	elog
	[ "${FRITZCAPI_BUILD_TARGETS/usb2/}" != "${FRITZCAPI_BUILD_TARGETS}" ] && (
		elog "Note: This ebuild has already installed firmware files necessary for following modules:"
		elog "   fcusb2"
	)
}
