# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-driver/madwifi-driver-0.1_pre20040824-r1.ebuild,v 1.1 2004/08/29 04:41:33 solar Exp $

# All work on madwifi is pretty much done under the WPA branch. At some
# point in the near future it should be merged back into HEAD. 
# cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/madwifi co -r WPA madwifi

inherit eutils kernel-mod

DESCRIPTION="Wireless driver for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="mirror://gentoo/$P.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}

pkg_setup() {
	if [[ "${KV}" > "2.5" ]] ; then
		cd ${ROOT}/usr/src/linux
		if [[ "${KV}" > "2.6.8" ]] ; then
			./scripts/mod/modpost ./vmlinux
		else
			./scripts/modpost ./vmlinux
		fi
	fi
}

src_unpack() {
	check_KV
	unpack ${A}
	cd ${S}

	# http://article.gmane.org/gmane.linux.drivers.madwifi.user/4033
	epatch ${FILESDIR}/madwifi-multi-ssid-support.patch

	if kernel-mod_is_2_6_kernel && [ ${KV_PATCH} -gt 5 ]; then
		for dir in ath ath_hal net80211; do
			sed -i -e "s:SUBDIRS=:M=:" ${S}/${dir}/Makefile
		done

		[[ "${KV_PATCH}" -ge 8 ]] && epatch ${FILESDIR}/${PN}-2.6.8-20040814-proc_dointvec.patch
	fi
}

src_compile() {
	unset ARCH
	make clean
	make KERNELPATH="${ROOT}/usr/src/linux" KERNELRELEASE="${KV}" || die
}

src_install() {
	unset ARCH
	make KERNELPATH="${ROOT}/usr/src/linux" KERNELRELEASE="${KV}" \
		DESTDIR="${D}" install || die

	dodoc README
}

pkg_postinst() {

	[ -r "${ROOT}/usr/src/linux/System.map" ] && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}

	einfo ""
	einfo "The madwifi drivers create an interface named 'athX'"
	einfo "Create /etc/init.d/net.ath0 and add a line for athX"
	einfo "in /etc/conf.d/net like 'iface_ath0=\"dhcp\"'"
	einfo ""
}
