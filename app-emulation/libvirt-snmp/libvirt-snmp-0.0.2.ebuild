# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt-snmp/libvirt-snmp-0.0.2.ebuild,v 1.2 2012/05/03 18:49:07 jdhore Exp $

EAPI=4

DESCRIPTION="Provides SNMP functionality for libvirt."
HOMEPAGE="http://libvirt.org"
SRC_URI="http://www.libvirt.org/sources/snmp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-emulation/libvirt
	net-analyzer/net-snmp"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	default
	newinitd "${FILESDIR}/libvirt-snmp.initd" "${PN}"
	newconfd "${FILESDIR}/libvirt-snmp.confd" "${PN}"
}

pkg_postinst() {
	elog "This daemon runs as an AgentX sub-daemon for snmpd. You should therefore"
	elog "enable the AgentX functionality in snmpd by specifying the following"
	elog "in /etc/snmp/snmpd.conf:"
	elog "  master agentx"
	elog "It is further recommended to send traps to the localhost as well using"
	elog "this option:"
	elog "  trap2sink localhost"
	elog "More information is available here:"
	elog "  http://wiki.libvirt.org/page/Libvirt-snmp"
}
