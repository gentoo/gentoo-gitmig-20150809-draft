# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/linux-wlan-ng/linux-wlan-ng-0.2.3.ebuild,v 1.2 2005/12/29 18:51:15 blubb Exp $

#The configure script needs prepared sources.
inherit linux-mod

DESCRIPTION="Programs/files needed for Prism2/2.5/3 based wireless LAN products"
HOMEPAGE="http://linux-wlan.org"
SRC_URI="ftp://ftp.linux-wlan.org/pub/linux-wlan-ng/${P}.tar.bz2"

# includes dual licensed files but also stuff only under MPL-1.1
LICENSE="|| ( GPL-2 MPL-1.1 ) MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug doc pcmcia"

DEPEND="~net-wireless/linux-wlan-ng-modules-${PV}
		~net-wireless/linux-wlan-ng-utils-0.2.2
		~net-wireless/linux-wlan-ng-firmware-0.2.2"

RDEPEND=${DEPEND}

#relative to src/
COMPILE_DIRS="mkmeta wlanctl wland nwepgen wlancfg prism2/download"
INSTALL_DIRS="${COMPILE_DIRS} ../etc"

CONFIG_FILE="${S}/default.config"
CONFIG_DIR="/etc/conf.d"

show_deprecated_message() {
	if use pci || use plx || use pcmcia; then
		einfo ""
		einfo "You really should try other alternatives for prism support."
		einfo "For example the hostap-driver or orinoco drivers should work"
		einfo "with your wireless card. Support for pci, plx and pcmcia drivers"
		einfo "will most likely be removed in the near future. If the alternatives"
		einfo "don't work for you, please report this to betelgeuse@gentoo.org."
		einfo ""
	fi
}

pkg_setup() {
	show_deprecated_message
}

config_by_usevar() {
	local config=${3}
	[[ -z ${config} ]] && config=${CONFIG_FILE}

	if use ${2}; then
		echo "${1}=y" >> ${config}
	else
		echo "${1}=n" >> ${config}
	fi
}

set_option() {
	local config=${3}
	[[ -z ${config} ]] && config=${CONFIG_FILE}

	echo "${1}=${2}" >> ${config}
}

src_unpack() {
	local config=${CONFIG_FILE}

	unpack ${A}

	rm ${S}/doc/rh71notes

	cd ${S}/etc
	mv rc.wlan rc.wlan.orig
	cp ${FILESDIR}/${PN}-gentoo-init rc.wlan

	#IMHO this should not be done but better to not upset users at this point
	sed -i -e "s:/etc/wlan:/etc/conf.d:g" ${S}/etc/wlan/Makefile
	sed -i -e "s:/etc/wlan/wlan.conf:/etc/conf.d/wlan.conf:g" \
		   -e "s:/etc/wlan/wlancfg:/etc/conf.d/wlancfg:g" \
		${S}/etc/wlan/shared

	cp ${S}/config.in ${config}

	set_option TARGET_ROOT_ON_HOST	${D}
	set_option LINUX_SRC			${KERNEL_DIR}
	set_option PRISM2_USB			n
	set_option PRISM2_PCI			n
	set_option PRISM2_PLX			n
	set_option PRISM2_PCMCIA		n

	if kernel_is gt 2 4; then
		set_option KERN_25 y
	fi

	config_by_usevar WLAN_DEBUG debug
}

src_compile() {
	set_arch_to_kernel
	emake default_config || die "emake default_config failed"
	set_arch_to_portage

	CONFIG_FILE="config.mk"

	set_option		 FIRMWARE_DIR  "/lib/firmware"
	config_by_usevar PRISM2_PCMCIA	pcmcia

	#For the scripts that go to /etc
	set_option TARGET_PCMCIA_DIR	${D}/etc/pcmcia

	cd ${S}/src/
	for dir in ${COMPILE_DIRS}; do
		pushd ${dir}
		make || die "make in ${dir} failed"
		popd
	done
}

src_install() {
	cd ${S}/man
	doman *.1

	for dir in ${INSTALL_DIRS}; do
		pushd ${S}/src/${dir}
		make install || die "make install in ${dir} failed"
		popd
	done

	cd ${S}

	dodir etc/wlan
	mv ${D}/etc/conf.d/shared ${D}/etc/wlan/

	if use doc; then
		insinto /usr/share/doc/${PF}/
		pushd ${S}/doc
		for file in $(ls); do
			[[ "${file}" != "Makefile" ]] && doins -r ${file}
		done
		popd
	fi

	dodoc CHANGES FAQ README THANKS TODO
}

pkg_postinst() {
	einfo "/etc/init.d/wlan is used to control startup and shutdown of non-PCMCIA devices."
	if use pcmcia; then
		einfo "/etc/init.d/pcmcia from pcmcia-cs is used to control startup and shutdown of"
		einfo "PCMCIA devices."
	fi
	einfo ""
	einfo "Modify ${CONFIG_DIR}/wlan.conf to set global parameters."
	einfo "Modify ${CONFIG_DIR}/wlancfg-* to set individual card parameters."
	einfo "There are detailed instructions in these config files."
	einfo ""
	einfo "Three keygen programs are included: nwepgen, keygen, and lwepgen."
	einfo "keygen seems provide more usable keys at the moment."
	einfo "You can change the keygen in your wlancfg-* files."
	einfo ""
	einfo "Be sure to add iface_wlan0 parameters to /etc/conf.d/net."
	einfo ""
	if use pcmcia; then
		ewarn "Wireless cards which you want to use drivers other than wlan-ng for"
		ewarn "need to have the appropriate line removed from /etc/pcmcia/wlan-ng.conf"
		ewarn "Do 'cardctl info' to see the manufacturer ID and remove the corresponding"
		ewarn "line from that file."
	fi
	show_deprecated_message
}

