# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.6.ebuild,v 1.3 2004/06/19 13:03:52 dholm Exp $

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
SRC_URI="mirror://sourceforge/${PN}/${PN}-v${PV}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${PN}-v${PV}/

DEPEND="virtual/glibc"

src_install() {
	dodir /sbin/
	einstall MANDIR=${D}/usr/share/man ETHERTYPESPATH=${D}/etc/ BINPATH=${D}/sbin/ || die
}
