# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-vpnclient-3des/cisco-vpnclient-3des-4.0.1a.ebuild,v 1.1 2003/07/05 12:42:36 blauwers Exp $

IUSE=""
At="vpnclient-linux-4.0.1.A-k9.tar.gz"
S="${WORKDIR}/vpnclient"
SRC_URI=""
DESCRIPTION="Cisco VPN Client (3DES)"
HOMEPAGE="http://www.cisco.com/en/US/products/sw/secursw/ps2308/index.html"
DEPEND="virtual/glibc
		virtual/linux-sources"
LICENSE="cisco-vpn-client"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha -hppa -mips -arm"

VPNDIR="/etc/CiscoSystemsVPNClient"

src_unpack() {
	if [ ! -f "${DISTDIR}/${At}" ] ; then
		die "Please download ${At} from ${HOMEPAGE} and move it to ${DISTDIR}."
	fi
	einfo "Cisco Systems VPN Client Version 4.0.1 (A) Linux Installer"
	einfo "Copyright (C) 1998-2001 Cisco Systems, Inc. All Rights Reserved."
	einfo ""
	einfo "By installing this product you agree that you have read the"
	einfo "license.txt file (The VPN Client license) and will comply with" 
	einfo "its terms. "
	einfo ""
	unpack "${At}"
}

src_compile () {
	check_KV
	sh ./driver_build.sh /lib/modules/${KV}/build
	if [ ! -f ./cisco_ipsec ]; then
		eerror "Failed to make module \"cisco_ipsec\"." && die
	fi
	sed "s#@VPNBINDIR@#/usr/bin#" < ./vpnclient_init > vpnclient_init.gentoo
    sed "s#@VPNBINDIR@#/usr/bin#" < ./vpnclient.ini.in > vpnclient.ini
}

src_install () {
	dodoc license.txt

	if [ -f "/etc/init.d/vpnclient" ]; then
		sh /etc/init.d/vpnclient stop
		einfo "Stopped: vpnclient (Cisco VPN service)"
	fi
	exeinto /etc/init.d
	newexe vpnclient_init.gentoo vpnclient

	exeinto /usr/bin
	exeopts -m0711
	doexe vpnclient
	exeopts -m4711
	doexe cvpnd
	dobin ipseclog
	dobin cisco_cert_mgr

	insinto /lib/modules/preferred/CiscoVPN
	doins cisco_ipsec

	dodir ${VPNDIR}
	dodir "$VPNDIR/Certificates"
	dodir "$VPNDIR/Profiles"

	insinto ${VPNDIR}
	doins vpnclient.ini

	insinto "${VPNDIR}/Profiles"
	doins *.pcf
}

pkg_postinst () {
	einfo  "You must run \"/etc/init.d/vpnclient start\" before using the client."
}
