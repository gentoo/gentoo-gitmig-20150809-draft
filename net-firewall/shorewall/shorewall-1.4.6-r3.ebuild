# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-1.4.6-r3.ebuild,v 1.1 2003/08/27 19:40:17 mholzer Exp $

S=${WORKDIR}/${P}c
DESCRIPTION="Full state iptables firewall"
SRC_URI="mirror://sourceforge/${PN}/${P}c.tgz"
HOMEPAGE="http://www.shorewall.net"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	net-firewall/iptables
	sys-apps/iproute"

RDEPENR=${DEPEND}

src_install () {
	keepdir /var/lib/shorewall
	PREFIX=${D} ./install.sh /etc/init.d || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/shorewall shorewall
	dohtml documentation/*.htm*
}
pkg_postinst() {
	einfo "Read the documentatition from http://www.shorewall.net"
	einfo "and edit the files in /etc/shorewall before starting the firewall"
}
