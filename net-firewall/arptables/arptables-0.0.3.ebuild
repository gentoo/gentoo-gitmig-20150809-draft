# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arptables/arptables-0.0.3.ebuild,v 1.6 2005/01/31 16:26:08 blubb Exp $

EXT=-2
DESCRIPTION="Arptables is used to set up, maintain, and inspect the tables of ARP rules in the Linux kernel. It is analogous to iptables, but operates at the ARP layer rather than the IP layer."
SRC_URI="mirror://sourceforge/ebtables/${PN}-v${PV}${EXT}.tar.gz"

HOMEPAGE="http://ebtables.sourceforge.net/"
KEYWORDS="~x86 ~amd64"
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
