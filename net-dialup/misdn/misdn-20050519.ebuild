# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdn/misdn-20050519.ebuild,v 1.1 2005/05/30 19:00:12 genstef Exp $

inherit eutils linux-mod

MY_P=mISDN-CVS-${PV:0:4}-${PV:4:2}-${PV:6:2}
DESCRIPTION="mISDN (modular ISDN) is the new ISDN stack of the linux kernel version 2.6."
HOMEPAGE="http://www.isdn4linux.de/mISDN"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2
	ftp://linux.mathematik.tu-darmstadt.de/pub/linux/mirrors/misc/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2
	ftp://ftp.cs.tu-berlin.de/pub/net/isdn/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2
	ftp://ftp.gwdg.de/pub/linux/isdn/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=net-dialup/capi4k-utils-20050322-r1"
S=${WORKDIR}/${MY_P}/drivers/isdn/hardware/mISDN/

MISDN_MODULES=("avmfritz" "hfcpci" "hfcmulti" "hfcsusb" "sedlfax" "w6692pci")
MISDN_KCONFIG=("AVM_FRITZ" "HFCPCI" "HFCMULTI" "HFCUSB" "SPEEDFAX" "W6692" )

pkg_setup() {
	CONFIG_CHECK="ISDN_CAPI ISDN_CAPI_CAPI20 ISDN_CAPI_CAPIFS_BOOL"
	linux-mod_pkg_setup
	MODULE_NAMES="mISDN_capi(net:) mISDN_dtmf(net:) mISDN_l1(net:)
	mISDN_x25dte(net:) l3udss1(net:) mISDN_core(net:) mISDN_isac(net:)
	mISDN_l2(net:) faxl3(net:) mISDN_dsp(net:)"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} EXTRA_CFLAGS=-I${WORKDIR}/${MY_P}/include CONFIG_MISDN_DRV=m CONFIG_MISDN_DSP=y"
	BUILD_TARGETS="modules"
	#I4LmISDN(net:) does not compile :( CONFIG_I4L_CAPI_LAYER=m
	# the i4l->capi simulation seems to be only for kernel 2.4

	if [ -n "${MISDN_CARDS}" ]; then
		#Check existence of user selected cards
		for USERCARD in ${MISDN_CARDS} ; do
			for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${MISDN_MODULES[CARD]}" ]; then
					MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
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
			BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=y"
		done
	fi
}

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	kernel_is ge 2 6 10 && \
		sed -i 's:pci_find_subsys:pci_get_subsys:g' \
		drivers/isdn/hardware/mISDN/hfc_multi.c
}

src_compile() {
	mv Makefile.v2.6 Makefile
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	insinto /etc/modules.d
	newins ${FILESDIR}/misdn.modulesd misdn

	dodoc Kconfig.v2.6
}

pkg_postinst() {
	update_depmod
	update_modules

	ewarn
	ewarn "This driver is still under heavy development"
	ewarn "Please report ebuild related bugs / wishes to http://bugs.gentoo.org"
	ewarn "Please report driver bugs to the mISDN mailing-list:"
	ewarn "    https://www.isdn4linux.de/mailman/listinfo/isdn4linux"
}
