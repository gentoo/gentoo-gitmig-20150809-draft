# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-1.4.6-r3.ebuild,v 1.3 2003/09/10 05:35:12 vapier Exp $

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}c.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc
	net-firewall/iptables
	sys-apps/iproute"

S=${WORKDIR}/${P}c

src_install() {
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
