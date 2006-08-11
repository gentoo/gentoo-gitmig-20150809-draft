# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdn/misdn-20060811.ebuild,v 1.1 2006/08/11 21:25:54 genstef Exp $

inherit eutils linux-mod

MY_P="mISDN-CVS-${PV:0:4}-${PV:4:2}-${PV:6:2}"
DESCRIPTION="mISDN is the new ISDN stack of the linux kernel 2.6."
HOMEPAGE="http://www.isdn4linux.de/mISDN"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
RDEPEND=">=net-dialup/capi4k-utils-20050322-r1"
S="${WORKDIR}/${MY_P}/drivers/isdn/hardware/mISDN"

MISDN_MODULES=("avmfritz" "hfcpci" "hfcmulti" "hfcsusb" "hfcsmini" "xhfc" "sedlfax" "w6692pci" "netjetpci")
MISDN_KCONFIG=("AVM_FRITZ" "HFCPCI" "HFCMULTI" "HFCUSB" "HFCMINI" "XHFC" "SPEEDFAX" "W6692" "NETJET")
for i in ${MISDN_MODULES[@]}; do IUSE="${IUSE} misdn_cards_${i}"; done

pkg_setup() {
	CONFIG_CHECK="ISDN_CAPI ISDN_CAPI_CAPI20 ISDN_CAPI_CAPIFS_BOOL"
	linux-mod_pkg_setup
	MODULE_NAMES="mISDN_capi(net:) mISDN_dtmf(net:) mISDN_l1(net:)
	mISDN_x25dte(net:) l3udss1(net:) mISDN_core(net:) mISDN_isac(net:)
	mISDN_l2(net:) mISDN_dsp(net:)"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} MINCLUDES=${WORKDIR}/${MY_P}/include CONFIG_MISDN_DRV=m CONFIG_MISDN_DSP=y"
	BUILD_TARGETS="modules"
	#I4LmISDN(net:) does not compile :( CONFIG_I4L_CAPI_LAYER=m
	# the i4l->capi simulation seems to be only for kernel 2.4

	if [ -n "${MISDN_CARDS}" ]; then
		#Check existence of user selected cards
		for USERCARD in ${MISDN_CARDS} ; do
			for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${MISDN_MODULES[CARD]}" ]; then
					MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
					#[ "sedlfax" = "${MISDN_MODULES[CARD]}" ] && MODULE_NAMES="${MODULE_NAMES} faxl3(net:)"
					BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=y"
					continue 2
				fi
			done
			die "Module ${USERCARD} not present in ${P}"
		done
	else
		einfo
		einfo "You can control the modules which are built with the variable"
		einfo "MISDN_CARDS which should contain a blank separated list"
		einfo "of a selection from the following cards:"
		einfo "   ${MISDN_MODULES[*]}"
		einfo
		ewarn "I give you the chance of hitting Ctrl-C and make the necessary"
		ewarn "adjustments in /etc/make.conf."

		# enable everything
		for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
			MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
			#[ "sedlfax" = "${MISDN_MODULES[CARD]}" ] && MODULE_NAMES="${MODULE_NAMES} faxl3(net:)"
			BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=y"
		done
	fi
}

src_install() {
	linux-mod_src_install

	insinto /usr/include/linux
	doins "${WORKDIR}/${MY_P}/include/linux/"*.h

	dodir /etc/udev/rules.d
	echo 'KERNEL=="obj-*", NAME="mISDN", GROUP="dialout"' \
		> "${D}/etc/udev/rules.d/53-${PN}.rules"

	insinto /etc/modules.d
	newins "${WORKDIR}/${MY_P}/"mISDN.modprobe.d ${PN}

	sed -i -e "s:USER=.*:USER=root:" \
		-e "s:GROUP=.*:GROUP=dialout:" "${WORKDIR}/${MY_P}/"misdn-init
	dosbin "${WORKDIR}/${MY_P}/"misdn-init

	dodoc Kconfig.v2.6
	dodoc "${FILESDIR}/README.hfcmulti" "${WORKDIR}/${MY_P}/"README.misdn-init
}

pkg_preinst() {
	if [ -e ${ROOT}/etc/misdn-init.conf ]; then
		cp ${ROOT}/etc/misdn-init.conf ${IMAGE}/etc
	else
		sed -i -e "s:/etc/misdn-init.conf:${IMAGE}\0:" ${IMAGE}/usr/sbin/misdn-init
		${IMAGE}/usr/sbin/misdn-init config
		sed -i -e "s:${IMAGE}/etc/misdn-init.conf:/etc/misdn-init.conf:" ${IMAGE}/usr/sbin/misdn-init
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn
	ewarn "This driver is still under heavy development"
	ewarn "Please report ebuild related bugs / wishes to http://bugs.gentoo.org"
	ewarn "Please report driver bugs to the mISDN mailing-list:"
	ewarn "    https://www.isdn4linux.de/mailman/listinfo/isdn4linux"
}
