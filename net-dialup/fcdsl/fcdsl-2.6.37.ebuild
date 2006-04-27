# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcdsl/fcdsl-2.6.37.ebuild,v 1.3 2006/04/27 17:40:57 mrness Exp $

inherit linux-mod eutils rpm

DESCRIPTION="AVM FRITZ!Card DSL drivers for 2.6 kernel"
HOMEPAGE="http://www.avm.de/"

SRC_HEAD="ftp://ftp.suse.com/pub/suse/i386/10.1/SUSE-Linux10.1-Beta3-Extra/suse"
SRC_URI="x86? ( ${SRC_HEAD}/i586/km_${P/2.6./2.6-}.i586.rpm
		${SRC_HEAD}/i586/avm_${P/2.6./2.6-}.i586.rpm )
	amd64? ( ${SRC_HEAD}/x86_64/km_${P/2.6./2.6-}.x86_64.rpm
		${SRC_HEAD}/x86_64/avm_${P/2.6./2.6-}.x86_64.rpm )"

LICENSE="LGPL-2"
KEYWORDS="-* ~amd64 x86"
IUSE="unicode"
SLOT="0"

RDEPEND=">=net-dialup/capi4k-utils-20040810"

S="${WORKDIR}"

pkg_setup() {
	use x86 && FCDSL_MODULES=("fcdsl2" "fcdslsl" "fcdslusb" "fcdslslusb" "fcdslusb2"
		"fcdsl" "fcdslusba")
	use amd64 && FCDSL_MODULES=("fcdsl2" "fcdslsl" "fcdslusb" "fcdslslusb" "fcdslusb2")
	FCDSL_NAMES=("AVM FRITZ!Card DSL v2.0" "AVM FRITZ!Card DSL SL"
		"AVM FRITZ!Card DSL USB" "AVM FRITZ!Card DSL SL USB" "AVM Fritz!Card DSL USB v2.0"
		"AVM FRITZ!Card DSL" "AVM Fritz!Card DSL USB analog")
	FCDSL_BUSTYPES=("pci" "pci" "usb" "usb" "usb" "pci" "usb")
	FCDSL_IDS=("1244:2900" "1244:2700" "057c:2300" "057c:3500"
		"057c:3600" "1131:5402" "057c:3000")
	FCDSL_FIRMWARES=("fds2base.bin" "fdssbase.bin" "fdsubase.frm" "fdlubase.frm"
		"fds2base.frm" "fdslbase.bin" "fdlabase.frm")

	CONFIG_CHECK="ISDN_CAPI_CAPI20"
	linux-mod_pkg_setup

	MODULE_NAMES=""
	#Check existence of user selected cards
	if [ -n "${FCDSL_CARDS}" ] ; then
		for USERCARD in ${FCDSL_CARDS} ; do
			for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${FCDSL_MODULES[CARD]}" ]; then
					MODULE_NAMES="${MODULE_NAMES}
					${FCDSL_MODULES[CARD]}(net:${WORKDIR}/usr/src/kernel-modules/fcdsl/src/src.${FCDSL_MODULES[CARD]})"
					continue 2
				fi
			done
			die "Driver for ${USERCARD} not present in ${P}"
		done
	else
		einfo
		einfo "You can control the modules which are built with the variable"
		einfo "FCDSL_CARDS which should contain a blank separated list"
		einfo "of a selection from the following cards:"
		einfo "   ${FCDSL_MODULES[*]}"
		for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
			MODULE_NAMES="${MODULE_NAMES} ${FCDSL_MODULES[CARD]}(net:${WORKDIR}/usr/src/kernel-modules/fcdsl/src/src.${FCDSL_MODULES[CARD]})"
		done
	fi
	BUILD_TARGETS="all"
	BUILD_PARAMS="KDIR='${KV_DIR}' LIBDIR='${S}'"
}

src_unpack() {
	local rpm_archive
	for rpm_archive in ${A} ; do
		rpm_unpack "${DISTDIR}/${rpm_archive}" || die "failed to unpack ${rpm_archive} file"
	done

	cd "${S}"
	mv usr/src/kernel-modules/fcdsl/src/src.fcdslusb1 \
		usr/src/kernel-modules/fcdsl/src/src.fcdslusb

	if use x86; then
		for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
			cd usr/src/kernel-modules/fcdsl/src/src.${FCDSL_MODULES[CARD]}
			[ -f "${FILESDIR}/${FCDSL_MODULES[CARD]}.diff" ] && epatch "${FILESDIR}/${FCDSL_MODULES[CARD]}.diff"
			cd "${S}"
		done
	fi

	# convert docs from latin1 to UTF-8
	if use unicode; then
		for i in usr/share/doc/packages/avm_fcdsl/compile-help-german.txt etc/drdsl/drdsl.ini; do
			einfo "Converting '${i##*/}' to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_install() {
	linux-mod_src_install

	for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
		if [ -n "${FCDSL_CARDS}" ] ; then
			INS=""
			for USERCARD in ${FCDSL_CARDS} ; do
				if [ "${USERCARD}" = "${FCDSL_MODULES[CARD]}" ]; then INS="1"; fi
			done
			if [ -z "${INS}" ]; then continue; fi
		fi

		insinto /lib/firmware/isdn
		doins "${WORKDIR}/lib/firmware/isdn/${FCDSL_FIRMWARES[CARD]}"
	done

	insinto /etc/drdsl
	doins etc/drdsl/drdsl.ini
	dosbin sbin/drdsl

	cd usr/share/doc/packages/avm_fcdsl
	dodoc *.txt
	dohtml *.html *.jpg
	docinto example
	dodoc example/*
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "The preferred way to setup your card is either /etc/capi.conf"
	einfo "or hotplug, since USB-Cards are detected automatically."
	einfo
	einfo "If you want to setup your DSL card driver and create a peer file, please run:"
	einfo "    etc-update"
	einfo "    emerge --config '=${CATEGORY}/${PF}'"
	einfo "    /etc/init.d/capi start"
	einfo "    drdsl"
	#ewarn
	#ewarn "'drdsl' has now its own ebuild. Please emerge net-dialup/drdsl."
	epause 10
}

#pkg-config functions

detect_fcdsl_card() {
	PCI_IDS=""
	USB_IDS=""
	if [ -d /sys/bus ]; then
		if [ -d /sys/bus/pci/devices ]; then
			cd /sys/bus/pci/devices
			for PCI_DEVICE in *; do
				vendor="$(< ${PCI_DEVICE}/vendor)"
				device="$(< ${PCI_DEVICE}/device)"
				PCI_IDS="${PCI_IDS}${vendor:2}:${device:2} "
			done
		fi
		if [ -d /sys/bus/usb/devices ]; then
			cd /sys/bus/usb/devices
			for USB_DEVICE in [0-9]*; do
				if [ -f ${USB_DEVICE}/idVendor ]; then
					USB_IDS="${USB_IDS}$(< ${USB_DEVICE}/idVendor):$(< ${USB_DEVICE}/idProduct) "
				fi
			done
		fi
	fi

	FCDSL_MODULE=""
	for ((CARD=0; CARD < ${#FCDSL_IDS[*]}; CARD++)); do
		BUS_IDS=""
		if [ "${FCDSL_BUSTYPES[CARD]}" == "pci" ]; then
			BUS_IDS="${PCI_IDS}"
		else
			BUS_IDS="${USB_IDS}"
		fi
		for BUS_ID in ${BUS_IDS}; do
			if [ "${BUS_ID}" == "${FCDSL_IDS[CARD]}" ]; then
				einfo "Found: ${FCDSL_NAMES[CARD]}"
				FCDSL_FIRMWARE="${FCDSL_FIRMWARES[CARD]}"
				FCDSL_MODULE="${FCDSL_MODULES[CARD]}"
			fi
		done
	done
	if [ "${FCDSL_MODULE}" == "" ]; then
		ewarn "No AVM FRITZ!Card DSL found!"
	fi
}

readpassword() {
	VALUE_1=""
	VALUE_2=""
	while true; do
		einfo "Enter your password:"
		read -r -s VALUE_1
		einfo "Retype your password:"
		read -r -s VALUE_2
		if [ "${VALUE_1}" == "" ]; then
			echo
			eerror "You entered a blank password. Please try again."
			echo
		else
			if [ "${VALUE_1}" == "${VALUE_2}" ] ; then
				break
			else
				echo
				eerror "Your password entries do not match. Please try again."
				echo
			fi
		fi
	done
	eval ${1}=${VALUE_1}

	VALUE_1=""
	VALUE_2=""
	unset VALUE_1
	unset VALUE_2
}

readvalue() {
	VALUE=""
	while true; do
		einfo "${2}:"
		read VALUE
		if [ "${VALUE}" == "" ]; then
			eerror "You entered a blank value. Please try again."
			echo
		else
			break
		fi
	done
	eval ${1}=${VALUE}

	VALUE=""
	unset VALUE
}

pkg_config() {
	detect_fcdsl_card

	if [ "${FCDSL_MODULE}" != "" ]; then
		readvalue FCDSL_PROVIDER "Enter the name of your ISP"
		if [ ! -e "/etc/ppp/peers/${FCDSL_PROVIDER}" ]; then
			readvalue FCDSL_USER "Enter your user name"
			if ! grep "${FCDSL_USER}" /etc/ppp/pap-secrets >/dev/null 2>&1; then
				readpassword FCDSL_PASSWORD
				echo '"'${FCDSL_USER}'" * "'${FCDSL_PASSWORD}'"' >>/etc/ppp/pap-secrets
				unset FCDSL_PASSWORD
				cat <<EOF >"/etc/ppp/peers/${FCDSL_PROVIDER}"
connect ""
ipcp-accept-remote
ipcp-accept-local
usepeerdns
defaultroute
user "${FCDSL_USER}"
hide-password
sync
noauth
lcp-echo-interval 5
lcp-echo-failure 3
lcp-max-configure 50
lcp-max-terminate 2
noccp
noipx
noproxyarp
mru 1492
mtu 1492
linkname "${FCDSL_PROVIDER}"
ipparam internet
plugin capiplugin.so
avmadsl
:
/dev/null
EOF
				echo
				echo
				echo
				einfo "Now, you can start an ADSL connection with either"
				einfo "    pon \"${FCDSL_PROVIDER}\""
				einfo "or"
				einfo "    pppd call \"${FCDSL_PROVIDER}\""
			else
				ewarn "User \"${FCDSL_USER}\" already exists in \"/etc/ppp/pap-secrets\"!"
			fi
		else
			ewarn "Peer file \"/etc/ppp/peers/${FCDSL_PROVIDER}\" already exists!"
		fi

		#Uncomment correspondent lines in /etc/capi.conf & /etc/modules.d/fcdsl
		if [ -f /etc/capi.conf ]; then
			sed -i -e "s:^#${FCDSL_MODULE}:${FCDSL_MODULE}:" \
				/etc/capi.conf >/dev/null 2>&1
		fi
		if [ -f /etc/modules.d/fcdsl ]; then
			sed -i -e "s:^#options ${FCDSL_MODULE}:options ${FCDSL_MODULE}:" \
				/etc/modules.d/fcdsl >/dev/null 2>&1
		fi
	else
		ewarn "No AVM FRITZ!Card DSL found!"
	fi
	unset FCDSL_PROVIDER
	unset FCDSL_USER
}
