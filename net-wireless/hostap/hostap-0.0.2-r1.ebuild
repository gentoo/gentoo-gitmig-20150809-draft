# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap/hostap-0.0.2-r1.ebuild,v 1.1 2003/05/15 12:23:29 phosphan Exp $

inherit eutils

DESCRIPTION="HostAP wireless drivers"
HOMEPAGE="http://hostap.epitest.fi/"

MY_PCMCIA="pcmcia-cs-3.2.1"
PATCH_3_2_2="${MY_PCMCIA}-3.2.2.diff.gz"
PATCH_3_2_3="${MY_PCMCIA}-3.2.3.diff.gz"
PATCH_3_2_4="${MY_PCMCIA}-3.2.4.diff.gz"

SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz
		pcmcia? ( mirror://sourceforge/pcmcia-cs/${MY_PCMCIA}.tar.gz )
		pcmcia? ( mirror://gentoo/${PATCH_3_2_2} )
		pcmcia? ( mirror://gentoo/${PATCH_3_2_3} )
		pcmcia? ( mirror://gentoo/${PATCH_3_2_4} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="pcmcia"

DEPEND=">=net-wireless/wireless-tools-25
		pcmcia? ( >=sys-apps/pcmcia-cs-3.2.1* )"

LIB_PATH="/lib/modules/${KV}"

if [  x"${HOSTAP_DRIVERS}" = x ]; then
	CUSTOM="no"
else
	CUSTOM="yes"
fi

src_unpack() {
	check_KV
	unpack ${P}.tar.gz

	if [ -n "`use pcmcia`" ]; then
		unpack ${MY_PCMCIA}.tar.gz
		cd ${WORKDIR}/${MY_PCMCIA}
		if [ -z "`has_version =sys-apps/pcmcia-cs-3.2.4*`" ]; then
			epatch ${DISTDIR}/${PATCH_3_2_4}
		elif [ -z "`has_version =sys-apps/pcmcia-cs-3.2.3*`" ]; then
			epatch ${DISTDIR}/${PATCH_3_2_3}
		elif [ -z "`has_version =sys-apps/pcmcia-cs-3.2.2*`" ]; then
			epatch ${DISTDIR}/${PATCH_3_2_2}
		fi
	fi


	cd ${S}
	mv Makefile ${T}
	sed -e "s:gcc:${CC}:" \
		-e "s:-O2:${CFLAGS}:" \
		-e "s:\$(EXTRA_CFLAGS):\$(EXTRA_CFLAGS) -DPRISM2_HOSTAPD:" \
		${T}/Makefile > Makefile
	
	if [ -n "`use pcmcia`" ] || [[ "${HOSTAP_DRIVERS}" == *pccard* ]]; then
		mv Makefile ${T}
		sed -e "s:^PCMCIA_PATH=:PCMCIA_PATH=${WORKDIR}/${MY_PCMCIA}:" \
			${T}/Makefile > Makefile
	fi
	
	cd ${S}/hostapd
	mv Makefile ${T}
	sed -e "s:gcc:${CC}:" \
		-e "s:-O2:${CFLAGS}:" \
		${T}/Makefile > Makefile
}

src_compile() {
	#
	# This ebuild now uses a system similar to the alsa ebuild.
	# By default, it will install the pci and plx drivers, and
	# the pcmcia drivers if pcmcia is in your use variables. To
	# specify exactly which drivers to build, do something like
	#
	#     HOSTAP_DRIVERS="pci pccard" emerge hostap
	#
	# Available options are pci, plx, and pccard.
	#
	# If you experience problems compiling the hostap_pci module,
	# try disabling CONFIG_MODVERSION from your kernel.
	#

	if [ "${CUSTOM}" == yes ]; then
		einfo "Building the folowing drivers: ${HOSTAP_DRIVERS}"
		emake ${HOSTAP_DRIVERS} hostap crypt || die
	else
		if [ -n "`use pcmcia`" ]; then
			einfo "Building the folowing drivers: pci plx pccard"
			emake pci plx pccard || die
		else
			einfo "Building the folowing drivers: pci plx"
			emake pci plx || die
		fi
	fi

	cd ${S}/hostapd
	emake || die
}

src_install() {
	dodir ${LIB_PATH}/net
	cp ${S}/driver/modules/{hostap.o,hostap_crypt.o,hostap_crypt_wep.o}\
		${D}${LIB_PATH}/net/

	if [ "${CUSTOM}" == "no" ]; then

		if [ -n "`use pcmcia`" ]; then
			dodir ${LIB_PATH}/pcmcia
			dodir /etc/pcmcia
			cp ${S}/driver/modules/hostap_cs.o ${D}/${LIB_PATH}/pcmcia/
			cp ${S}/driver/etc/hostap_cs.conf ${D}/etc/pcmcia/
			if [ -r /etc/pcmcia/prism2.conf ]; then
				einfo "You may need to edit or remove /etc/pcmcia/prism2.conf"
				einfo "This is usually a result of conflicts with the"
				einfo "linux-wlan-ng drivers."
			fi
		fi
		for driver in ${HOSTAP_DRIVERS}; do
			cp ${S}/driver/modules/hostap_${driver}.o\
				${D}${LIB_PATH}/net/;
		done
	elif [ "${CUSTOM}" == "yes" ]; then
		if [[ "${HOSTAP_DRIVERS}" = *pccard* ]]; then
			dodir ${LIB_PATH}/pcmcia
			dodir /etc/pcmcia
			cp ${S}/driver/modules/hostap_cs.o ${D}/${LIB_PATH}/pcmcia/
			cp ${S}/driver/etc/hostap_cs.conf ${D}/etc/pcmcia/
			if [ -r /etc/pcmcia/prism2.conf ]; then
				einfo "You may need to edit or remove /etc/pcmcia/prism2.conf"
				einfo "This is usually a result of conflicts with the"
				einfo "linux-wlan-ng drivers."
			fi
		fi

		if [[ "${HOSTAP_DRIVERS}" = *pci* ]]; then
			cp ${S}/driver/modules/hostap_pci.o\
				${D}${LIB_PATH}/net/
		fi

		if [[ "${HOSTAP_DRIVERS}" = *plx* ]]; then
			cp ${S}/driver/modules/hostap_plx.o\
				${D}${LIB_PATH}/net/
		fi

	fi

	dodoc FAQ README README.prism2 ChangeLog

	dosbin hostapd/hostapd
}
pkg_postinst(){
	/sbin/depmod -a
}
