# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-1.4.5-r1.ebuild,v 1.4 2003/09/08 07:11:32 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Full state iptables firewall"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://www.shorewall.net"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha"
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
