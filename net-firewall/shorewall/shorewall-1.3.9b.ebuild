# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-misc/shorewall/shorewall-1..3.9b.ebuild

DESCRIPTION="Full state iptables firewall"
SRC_URI="http://www.shorewall.net/pub/shorewall/${P}.tgz"
HOMEPAGE="http://www.shorewall.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"

DEPEND="virtual/glibc
	net-firewall/iptables
	sys-apps/iproute"

src_install() {
	dodir /etc/init.d
	dodir /var/state
	PREFIX=${D} ./install.sh || die
	rm -f ${D}/usr/lib/shorewall/firewall
	cp ${D}/etc/init.d/shorewall ${D}/usr/lib/shorewall/firewall
	rm -rf ${D}/etc/init.d

	exeinto /etc/init.d
	newexe ${FILESDIR}/shorewall shorewall
}

pkg_postinst() {
	einfo "Read the documentatition from http://www.shorewall.net/"
	einfo "and edit the files in /etc/shorewall before starting the firewall"
	echo
}
