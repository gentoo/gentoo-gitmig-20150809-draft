# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-vpnclient-3des/cisco-vpnclient-3des-4.0.1a-r1.ebuild,v 1.17 2006/12/04 14:42:42 wolf31o2 Exp $

inherit eutils linux-mod

MY_PV=${PV/a/.A-k9}
DESCRIPTION="Cisco VPN Client (3DES)"
HOMEPAGE="http://www.cisco.com/en/US/products/sw/secursw/ps2308/index.html"
SRC_URI="vpnclient-linux-${MY_PV}.tar.gz"

LICENSE="cisco-vpn-client"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="fetch strip" # stricter"

QA_TEXTRELS="opt/cisco-vpnclient/lib/libvpnapi.so"
QA_EXECSTACK="opt/cisco-vpnclient/lib/libvpnapi.so
	opt/cisco-vpnclient/bin/vpnclient
	opt/cisco-vpnclient/bin/cvpnd
	opt/cisco-vpnclient/bin/cisco_cert_mgr
	opt/cisco-vpnclient/bin/ipseclog"

S=${WORKDIR}/vpnclient

VPNDIR=/etc/CiscoSystemsVPNClient

pkg_nofetch() {
	eerror "Please goto:"
	eerror " ${HOMEPAGE}"
	eerror "and download"
	eerror " ${A}"
	eerror "to ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	if kernel_is 2 6; then
		epatch ${FILESDIR}/${PV}-linux26-gentoo.patch
	fi

	# Patch to allow use of alternate CC.  Patch submitted to bug #33488 by
	# Jesse Becker (jbecker@speakeasy.net)
	epatch ${FILESDIR}/driver_build_CC.patch

}

src_compile () {
	unset ARCH
	sh ./driver_build.sh ${KV_DIR}
	[ ! -f ./cisco_ipsec ] && die "Failed to make module 'cisco_ipsec'"
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient_init
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient.ini.in
}

src_install() {
	exeinto /etc/init.d
	newexe vpnclient_init vpnclient

	exeinto /usr/bin
	exeopts -m0711
	doexe vpnclient
	exeopts -m4711
	doexe cvpnd
	dobin ipseclog cisco_cert_mgr

	insinto /lib/modules/${KV}/CiscoVPN
	doins cisco_ipsec

	insinto ${VPNDIR}
	newins vpnclient.ini.in vpnclient.ini
	insinto ${VPNDIR}/Profiles
	doins *.pcf
	dodir ${VPNDIR}/Certificates
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo  "You must run \`/etc/init.d/vpnclient start\` before using the client."
}

