# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arptables/arptables-0.0.3.ebuild,v 1.5 2004/07/14 23:38:21 agriffis Exp $

EXT=-2
DESCRIPTION="Arptables is used to set up, maintain, and inspect the tables of ARP rules in the Linux kernel. It is analogous to iptables, but operates at the ARP layer rather than the IP layer."
SRC_URI="mirror://sourceforge/ebtables/${PN}-v${PV}${EXT}.tar.gz"

HOMEPAGE="http://ebtables.sourceforge.net/"
KEYWORDS="~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${PN}-v${PV}${EXT}/

DEPEND="virtual/libc"

src_compile() {
	cd ${S}
	emake
}

src_install() {
	dodir /sbin/
	einstall PREFIX=${D}/ MANDIR=${D}/usr/share/man/
}
