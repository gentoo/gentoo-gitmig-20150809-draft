# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap-driver/hostap-driver-0.2.4.ebuild,v 1.2 2004/11/01 11:49:36 brix Exp $

inherit toolchain-funcs pcmcia kernel-mod

DESCRIPTION="HostAP wireless drivers"
HOMEPAGE="http://hostap.epitest.fi/"
SRC_URI="${SRC_URI} http://hostap.epitest.fi/releases/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86"
IUSE="${IUSE} hostap-nopci hostap-noplx"
DEPEND=">=net-wireless/wireless-tools-25"
RDEPEND="!net-wireless/hostap"
SLOT="0"

KMOD_PATH="/lib/modules/${KV}"

src_unpack() {
	kernel-mod_getversion
	unpack ${A}
	## unpack the pcmcia-cs sources if needed
	pcmcia_src_unpack

	cd ${S}

	## set compiler options
	sed -i -e "s:gcc:$(tc-getCC):" ${S}/Makefile

	## fix for new coreutils (#31801)
	sed -i -e "s:tail -1:tail -n 1:" ${S}/Makefile

	## set correct pcmcia path (PCMCIA_VERSION gets set from pcmcia_src_unpack)
	if [ -n "${PCMCIA_VERSION}" ]; then
		sed -i -e "s:^PCMCIA_PATH=:PCMCIA_PATH=${PCMCIA_SOURCE_DIR}:" ${S}/Makefile
	fi

	if kernel-mod_is_2_6_kernel && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i -e "s:SUBDIRS=:M=:" ${S}/Makefile
	fi
}

src_compile() {
	## configure pcmcia
	pcmcia_configure

	cd ${S}

	einfo "Building hostap-driver for kernel version: ${KV}"
	case ${KV_MINOR} in
		[34])
			local mydrivers

			use pcmcia && mydrivers="${mydrivers} pccard"
			use hostap-nopci || mydrivers="${mydrivers} pci"
			use hostap-noplx || mydrivers="${mydrivers} plx"

			einfo "Building the following drivers: ${mydrivers}"
			emake ${mydrivers} || die "make failed"
			;;
		[56])
			unset ARCH
			emake all || die "make failed"
			;;
		*)
			eerror "Unsupported kernel version: ${KV}"
			die
			;;
	esac
}

src_install() {
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ=ko
	else
		KV_OBJ=o
	fi

	## kernel 2.6 has a different module file name suffix
	dodir ${KMOD_PATH}/net
	cp ${S}/driver/modules/{hostap,hostap_crypt_{wep,tkip,ccmp}}.${KV_OBJ} \
		${D}${KMOD_PATH}/net/

	if use pcmcia >&/dev/null; then
		dodir ${KMOD_PATH}/pcmcia
		dodir /etc/pcmcia
		cp ${S}/driver/modules/hostap_cs.${KV_OBJ} ${D}/${KMOD_PATH}/pcmcia/
		cp ${S}/driver/etc/hostap_cs.conf ${D}/etc/pcmcia/
		if [ -r /etc/pcmcia/prism2.conf ]; then
			einfo "You may need to edit or remove /etc/pcmcia/prism2.conf"
			einfo "This is usually a result of conflicts with the"
			einfo "linux-wlan-ng drivers."
		fi
	fi

	if ! use hostap-nopci >&/dev/null; then
		cp ${S}/driver/modules/hostap_pci.${KV_OBJ} \
			${D}${KMOD_PATH}/net/
	fi

	if ! use hostap-noplx >&/dev/null; then
		cp ${S}/driver/modules/hostap_plx.${KV_OBJ} \
			${D}${KMOD_PATH}/net/
	fi
	dodoc README ChangeLog
}
