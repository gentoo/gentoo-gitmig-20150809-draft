# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arptables/arptables-0.0.3.ebuild,v 1.1 2004/02/28 09:33:02 solar Exp $

EXT=-2
DESCRIPTION="Arptables is used to set up, maintain, and inspect the tables of ARP rules in the Linux kernel. It is analogous to iptables, but operates at the ARP layer rather than the IP layer."
SRC_URI="mirror://sourceforge/ebtables/${PN}-v${PV}${EXT}.tar.gz"

HOMEPAGE=""
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${PN}-v${PV}${EXT}/

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	emake
}

src_install() {
	dodir /sbin/
	einstall PREFIX=${D}/ MANDIR=${D}/usr/share/man/
}
