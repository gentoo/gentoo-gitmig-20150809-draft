# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcdsl/fcdsl-2.6.20.7-r4.ebuild,v 1.6 2005/03/30 09:15:31 mr_bones_ Exp $

inherit linux-mod eutils

FCDSL_SRC=("fritzcrd.dsl" "fritzcrd.dsl_v20" "fritzcrd.dsl_sl"
	"fritzcrd.dsl_usb" "fritzcrd.dsl_sl_usb")
FCDSL_FILES=("fcdsl-suse9.1-3.11-02" "fcdsl2-suse9.1-3.11-04"
	"fcdslsl-suse9.1-3.11-04" "fcdslusb-suse9.1-3.11-02"
	"fcdslslusb-suse9.1-3.11-04")

DESCRIPTION="AVM FRITZ!Card DSL drivers for 2.6 kernel"
HOMEPAGE="http://www.avm.de/"
SRC_URI=""
for ((CARD=0; CARD < ${#FCDSL_SRC[*]}; CARD++)); do
	SRC_URI="${SRC_URI}
	ftp://ftp.avm.de/cardware/${FCDSL_SRC[CARD]}/linux/suse.91/${FCDSL_FILES[CARD]}.tar.gz"
done

LICENSE="LGPL-2"
KEYWORDS="x86"
IUSE=""
SLOT="0"
S=${WORKDIR}/fritz

RDEPEND=">=net-dialup/capi4k-utils-20040810"

FCDSL_NAMES=("AVM FRITZ!Card DSL" "AVM FRITZ!Card DSL v2.0" "AVM FRITZ!Card DSL SL" "AVM FRITZ!Card DSL USB" "AVM FRITZ!Card DSL SL USB")
FCDSL_BUSTYPES=("pci" "pci" "pci" "usb" "usb")
FCDSL_IDS=("1131:5402" "1244:2900" "1244:2700" "057c:2300" "057c:3500")
FCDSL_FIRMWARES=("fdslbase.bin" "fds2base.bin" "fdssbase.bin" "fdsubase.frm" "fdlubase.frm")
FCDSL_MODULES=("fcdsl" "fcdsl2" "fcdslsl" "fcdslusb" "fcdslslusb")

pkg_setup() {
	CONFIG_CHECK="ISDN_CAPI_CAPI20"
	linux-mod_pkg_setup

	MODULE_NAMES=""
	#Check existence of user selected cards
	if [ -n "${FCDSL_CARDS}" ] ; then
		for USERCARD in ${FCDSL_CARDS} ; do
			for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${FCDSL_MODULES[CARD]}" ]; then
					MODULE_NAMES="${MODULE_NAMES} ${FCDSL_MODULES[CARD]}(net:${WORKDIR}/${FCDSL_MODULES[CARD]/fc/fritz.}/src)"
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
			MODULE_NAMES="${MODULE_NAMES} ${FCDSL_MODULES[CARD]}(net:${WORKDIR}/${FCDSL_MODULES[CARD]/fc/fritz.}/src)"
		done
	fi
	BUILD_TARGETS="all"
	BUILD_PARAMS="KDIR=${KV_DIR} LIBDIR=${S}"
	NO_MODULESD="1"
}

src_unpack() {
	for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
		tar xzf ${DISTDIR}/${FCDSL_FILES[CARD]}.tar.gz
		mv fritz ${FCDSL_MODULES[CARD]/fc/fritz.}
		cd ${FCDSL_MODULES[CARD]/fc/fritz.}/src
		[ -f ${FILESDIR}/${FCDSL_MODULES[CARD]}.diff ] && patch -p0 < ${FILESDIR}/${FCDSL_MODULES[CARD]}.diff
		cd ../..
	done

	ln -s ${FCDSL_MODULES[0]/fc/fritz.} fritz
}

src_install() {
	linux-mod_src_install

	dodir /etc/drdsl /etc/modules.d /lib/firmware /usr/sbin

	echo "# modules.d config file for AVM FRITZ!Card DSL" >${D}/etc/modules.d/fcdsl
	echo "# Correct these settings with the output from drdsl -n" >>${D}/etc/modules.d/fcdsl

	for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
		if [ -n "${FCDSL_CARDS}" ] ; then
			INS=""
			for USERCARD in ${FCDSL_CARDS} ; do
				if [ "${USERCARD}" = "${FCDSL_MODULES[CARD]}" ]; then INS="1"; fi
			done
			if [ -z "${INS}" ]; then continue; fi
		fi

		echo "#options ${FCDSL_MODULES[CARD]} VPI=1 VCI=32 VCC=1" >>${D}/etc/modules.d/fcdsl

		insinto /lib/firmware
		doins ${WORKDIR}/${FCDSL_MODULES[CARD]/fc/fritz.}/${FCDSL_FIRMWARES[CARD]}
	done

	insinto /etc/drdsl
	doins ${S}/drdsl.ini

	exeinto /usr/sbin
	doexe ${S}/drdsl

	dodoc ${S}/CAPI* ${S}/compile* ${S}/license.txt
}

pkg_postinst() {
	linux-mod_pkg_postinst

	echo
	einfo "If you want to setup your DSL card driver and create a peer file, please run:"
	einfo "    etc-update"
	einfo "    ebuild /var/db/pkg/net-dialup/${PF}/${PF}.ebuild config"
	einfo "    /etc/init.d/capi start"
	einfo "    drdsl -n"
	einfo "    nano /etc/modules.d/fcdsl"
	einfo "    update-modules"
	einfo "    /etc/init.d/capi restart"
	ewarn
	ewarn "drdsl does NOT work with capi4k-utils-2005* because its binary incompatible"
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
				FCDSL_FIRMWARE=${FCDSL_FIRMWARES[CARD]}
				FCDSL_MODULE=${FCDSL_MODULES[CARD]}
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
				cat <<EOF >/etc/ppp/peers/${FCDSL_PROVIDER}
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
