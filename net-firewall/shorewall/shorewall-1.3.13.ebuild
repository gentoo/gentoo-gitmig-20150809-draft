# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/net-misc/shorewall/shorewall-1..3.9b.ebuild

S=${WORKDIR}/${P}
DESCRIPTION="Full state iptables firewall"
SRC_URI="http://www.shorewall.net/pub/shorewall/${P}.tgz"
HOMEPAGE="http://www.shorewall.net"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"

DEPEND="virtual/glibc
	net-firewall/iptables
	sys-apps/iproute"

RDEPENR=${DEPEND}

src_install () {
	dodir /etc/init.d /var/state
	PREFIX=${D} ./install.sh || die
	
	exeinto /etc/init.d
	newexe ${FILESDIR}/shorewall shorewall
}
pkg_postinst() {
	einfo "Read the documentatition from http://www.shorewall.net"
	einfo "and edit the files in /etc/shorewall before starting the firewall"
}
