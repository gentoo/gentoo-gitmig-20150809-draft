# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcdsl/fcdsl-2.6.20.7-r1.ebuild,v 1.3 2004/11/21 21:31:49 mrness Exp $

inherit kernel-mod rpm eutils

S="${WORKDIR}/fritz"

DESCRIPTION="AVM FRITZ!Card DSL drivers for 2.6 kernel"
HOMEPAGE="http://www.avm.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/update/9.1/rpm/src/avm_${P/2.6./2.6-}.src.rpm"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=net-dialup/capi4k-utils-20040810"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/sed
	virtual/linux-sources"

FCDSL_NAMES=("AVM FRITZ!Card DSL" "AVM FRITZ!Card DSL v2.0" "AVM FRITZ!Card DSL SL" "AVM FRITZ!Card DSL USB" "AVM FRITZ!Card DSL SL USB")
FCDSL_BUSTYPES=("pci" "pci" "pci" "usb" "usb")
FCDSL_IDS=("1131:5402" "1244:2900" "1244:2700" "057c:2300" "057c:3500")
FCDSL_FIRMWARES=("fdslbase.bin" "fds2base.bin" "fdssbase.bin" "fdsubase.frm" "fdlubase.frm")
FCDSL_MODULES=("fcdsl" "fcdsl2" "fcdslsl" "fcdslusb" "fcdslslusb")

detect_fcdsl_card() {
	PCI_IDS=""
	USB_IDS=""
	if [ -d /sys/bus ]; then
		if [ -d /sys/bus/pci/devices ]; then
			cd /sys/bus/pci/devices
			for PCI_DEVICE in *; do
				PCI_IDS="${PCI_IDS}$(cat ${PCI_DEVICE}/vendor | sed -e 's:0\x::'):$(cat ${PCI_DEVICE}/device | sed -e 's:0\x::') "
			done
			unset PCI_DEVICE
		fi
		if [ -d /sys/bus/usb/devices ]; then
			cd /sys/bus/usb/devices
			for USB_DEVICE in [0-9]*; do
				if [ -f ${USB_DEVICE}/idVendor ]; then
					USB_IDS="${USB_IDS}$(cat ${USB_DEVICE}/idVendor):$(cat ${USB_DEVICE}/idProduct) "
				fi
			done
			unset USB_DEVICE
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

pkg_setup() {
	if ! kernel-mod_is_2_6_kernel; then
		die "This package works only with 2.6 kernel!"
	fi
	if ! kernel-mod_configoption_present ISDN_CAPI_CAPI20; then
		die "For using the driver you need a kernel with enabled CAPI support."
	fi
	kernel-mod_check_modules_supported
}

src_unpack() {
	rpm_src_unpack ${A} || die "Could not unpack RPM package."
}

src_compile() {
	set_arch_to_kernel
	for ((CARD=0; CARD < ${#FCDSL_IDS[*]}; CARD++)); do
		einfo "Compiling driver for ${FCDSL_NAMES[CARD]}"
		cd ${WORKDIR}/${FCDSL_MODULES[CARD]/fc/fritz.}/src || die "Could not change to ${FCDSL_NAMES[CARD]} source directory."
		kernel-mod_src_compile || die "Could not compile driver for ${FCDSL_NAMES[CARD]}."
	done
	set_arch_to_portage
}

src_install() {
	dodir /etc/drdsl /etc/modules.d /lib/modules/${KV_VERSION_FULL}/misc /usr/lib/isdn /lib/firmware /usr/sbin

	echo -e "# card\tfile\tproto\tio\tirq\tmem\tcardnr\toptions" >${D}/etc/capi.conf
	echo "#" >>${D}/etc/capi.conf

	echo "# Options for AVM FRITZ!Card DSL cards" >${D}/etc/modules.d/fcdsl
	echo "# Correct these settings with the output from drdsl -n" >>${D}/etc/modules.d/fcdsl

	for ((CARD=0; CARD < ${#FCDSL_MODULES[*]}; CARD++)); do
		echo -e "#${FCDSL_MODULES[CARD]}\t${FCDSL_FIRMWARES[CARD]}\t-\t-\t-\t-\t-" >>${D}/etc/capi.conf

		echo "#options ${FCDSL_MODULES[CARD]} VPI=1 VCI=32 VCC=1" >>${D}/etc/modules.d/fcdsl

		insinto /lib/modules/${KV_VERSION_FULL}/misc
		doins ${WORKDIR}/${FCDSL_MODULES[CARD]/fc/fritz.}/src/${FCDSL_MODULES[CARD]}.ko

		insinto /lib/firmware
		newins ${WORKDIR}/${FCDSL_MODULES[CARD]/fc/fritz.}/${FCDSL_FIRMWARES[CARD]} ${PN}_${FCDSL_FIRMWARES[CARD]}
		dosym /lib/firmware/${PN}_${FCDSL_FIRMWARES[CARD]} /usr/lib/isdn/${FCDSL_FIRMWARES[CARD]}
	done

	if ! [ "${FCDSL_MODULE}" == "" ]; then
		sed -si "s/^#\(options ${FCDSL_MODULE} VPI=1 VCI=32 VCC=1\)/\1/" ${D}/etc/modules.d/fcdsl
	fi

	insinto /etc/drdsl
	doins ${S}/drdsl.ini

	exeinto /usr/sbin
	doexe ${S}/drdsl

	dodoc ${S}/CAPI* ${S}/compile* ${S}/license.txt ${S}/release.txt
	dohtml install_passive-*.html

}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}

	echo
	einfo "If you want to setup your DSL card driver and create a peer file, please run:"
	einfo "    etc-update"
	einfo "    ebuild /var/db/pkg/net-dialup/${PF}/${PF}.ebuild config"
	einfo "    capiinit start"
	einfo "    drdsl -n"
	einfo "    nano /etc/modules.d/fcdsl"
	einfo "    update-modules"
	epause 10
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
			if [ "$(grep "${FCDSL_USER}" /etc/ppp/pap-secrets)" == "" ]; then
				readpassword FCDSL_PASSWORD
				echo '"'${FCDSL_USER}'" * "'${FCDSL_PASSWORD}'"' >>/etc/ppp/pap-secrets
				unset FCDSL_PASSWORD
				cat <<EOF >>/etc/ppp/peers/${FCDSL_PROVIDER}
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
				ewarn "User \"${FCDSL_USER}\" always exists in \"/etc/ppp/pap-secrets\"!"
			fi
		else
			ewarn "Peer file \"/etc/ppp/peers/${FCDSL_PROVIDER}\" always exists!"
		fi

		#Uncomment correspondent lines in /etc/capi.conf & /etc/modules.d/fcdsl
		if [ -f /etc/capi.conf ]; then
			sed -i -e "s:^#${FCDSL_MODULE}:${FCDSL_MODULE}" /etc/capi.conf
		fi
		if [ -f /etc/modules.d/fcdsl ]; then
			sed -i -e "s:^#options +${FCDSL_MODULE}:options ${FCDSL_MODULE}" /etc/modules.d/fcdsl
		fi
	else
		ewarn "No AVM FRITZ!Card DSL found!"
	fi
	unset FCDSL_PROVIDER
	unset FCDSL_USER
}
