# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hpasm/hpasm-6.30.0.12-r1.ebuild,v 1.18 2005/08/23 17:39:51 flameeyes Exp $

inherit rpm

MY_P=${P%.*}-${PV##*.}
S=${WORKDIR}
DESCRIPTION="hp Server Management Drivers and Agents"
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
SRC_URI="ftp://ftp.compaq.com/pub/products/servers/supportsoftware/linux/${MY_P}.Redhat8_0.i386.rpm"
IUSE="snmp"
LICENSE="hp-value"
SLOT="0"
KEYWORDS="x86"

RDEPEND="snmp? ( net-analyzer/net-snmp )"

DEPEND="${RDEPEND}
	virtual/linux-sources
	virtual/mailx
	app-arch/rpm2targz"

src_unpack() {
	rpm_src_unpack
	cd ${S}
	find ./ -type l -exec rm -f {} \;
}

src_install() {

	cp -pPR ${WORKDIR}/* ${D}

	dosym libcpqci.so.1.0 /opt/compaq/hpasm/addon/libcpqci.so.1
	dosym libcpqci.so.1.0 /opt/compaq/hpasm/addon/libcpqci.so

	dosym /opt/compaq/cpqhealth/cpqasm/hplogo.xbm /usr/share/pixmaps/hplogo.xbm
	dosym /opt/compaq/cpqhealth/cpqasm/m_blue.gif /usr/share/pixmaps/m_blue.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_fail.gif /usr/share/pixmaps/m_fail.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_green.gif /usr/share/pixmaps/m_green.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_red.gif /usr/share/pixmaps/m_red.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_yellow.gif /usr/share/pixmaps/m_yellow.gif

	dosym /opt/compaq/cpqhealth/cpqasm/cpqimlview /sbin/cpqimlview
	dosym /opt/compaq/cpqhealth/cpqasm/cpqimlview /sbin/hpimlview
	dosym /opt/compaq/cpqhealth/cpqasm/cpqimlview.tcl /sbin/cpqimlview.tcl
	dosym /opt/compaq/cpqhealth/hplog /sbin/hplog
	dosym /opt/compaq/cpqhealth/hpuid /sbin/hpuid
	dosym /opt/compaq/cpqhealth/cpqasm/imlbe /sbin/imlbe

	dosym /opt/compaq/hpasm/etc/rebuild /sbin/hpasm_rebuild

	dodir /usr/lib

	if [ ! -f /usr/lib/libcrypto.so.2 ] ; then
		dosym /usr/lib/libcrypto.so.0.9.6 /usr/lib/libcrypto.so.2
	fi

	if [ ! -f /usr/lib/libssl.so.2 ] ; then
		dosym /usr/lib/libssl.so.0.9.6 /usr/lib/libssl.so.2
	fi

	keepdir /var/spool/compaq
}

pkg_postinst() {
	einfo ""
	einfo "If you want to run cpqimlview or hpimlview you will"
	einfo "need to emerge an X11 implementation, tix, and tclx"
	einfo ""
	einfo "You now need to execute /etc/init.d/hpasm start in"
	einfo "order to use the installed package. The kernel"
	einfo "modules will automatically build for you."
	einfo ""
}
