# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-vpnclient-3des/cisco-vpnclient-3des-4.6.00.0045.ebuild,v 1.1 2004/11/04 01:18:27 wolf31o2 Exp $

inherit eutils kernel-mod

MY_PV=${PV}-k9
DESCRIPTION="Cisco VPN Client (3DES)"
HOMEPAGE="http://cco.cisco.com/en/US/products/sw/secursw/ps2308/index.html"
SRC_URI="vpnclient-linux-${MY_PV}.tar.gz"

LICENSE="cisco-vpn-client"
SLOT="${KV}"
KEYWORDS="-* ~x86"
IUSE=""
RESTRICT="fetch"

DEPEND="virtual/libc
	virtual/linux-sources
	>=sys-apps/sed-4"

S=${WORKDIR}/vpnclient

VPNDIR="/etc/opt/cisco-vpnclient/"

pkg_nofetch() {
	einfo "Please visit:"
	einfo " ${HOMEPAGE}"
	einfo "and download ${A} to ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to allow use of alternate CC.  Patch submitted to bug #33488 by
	# Jesse Becker <jbecker@speakeasy.net>
	epatch ${FILESDIR}/driver_build_CC.patch
}

src_compile () {
	unset ARCH
	sh ./driver_build.sh /lib/modules/${KV}/build
	[ ! -f ./cisco_ipsec -a ! -f ./cisco_ipsec.ko ] \
		&& die "Failed to make module 'cisco_ipsec'"
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient_init
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient.ini
}

src_install() {
	exeinto /etc/init.d
	newexe ${FILESDIR}/vpnclient.rc vpnclient

	exeinto /opt/cisco-vpnclient/bin
	exeopts -m0711
	doexe vpnclient
	exeopts -m4711
	doexe cvpnd
	into /opt/cisco-vpnclient/
	dobin ipseclog cisco_cert_mgr
	dolib.so libvpnapi.so
	doins vpnapi.h
	dodir /usr/bin
	dosym /opt/cisco-vpnclient/bin/vpnclient /usr/bin/vpnclient


	insinto /lib/modules/${KV}/CiscoVPN
	if kernel-mod_is_2_6_kernel; then
		doins cisco_ipsec.ko
	else
		doins cisco_ipsec
	fi

	insinto ${VPNDIR}
	doins vpnclient.ini
	insinto ${VPNDIR}/Profiles
	doins *.pcf
	dodir ${VPNDIR}/Certificates
}

pkg_postinst() {
	einfo "You must run \`/etc/init.d/vpnclient start\` before using the client."
	echo ""
	ewarn "Configuration directory has moved to ${VPNDIR}!"
	echo ""
}
