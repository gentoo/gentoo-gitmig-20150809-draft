# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/net-misc/shorewall/shorewall-1..3.9b.ebuild

MY_P=shorewall-1.3.9b
S=${WORKDIR}/${MY_P}
DESCRIPTION="Full state iptables firewall"
SRC_URI="http://www.shorewall.net/pub/shorewall/${MY_P}.tgz"
HOMEPAGE="http://www.shorewall.net"
LICENSE="GPL"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
SLOT="0"

DEPEND="virtual/glibc
	sys-apps/iptables
	sys-apps/iproute"

src_install () {
	mkdir -p ${D}/etc/init.d
	mkdir -p ${D}/var/state
	PREFIX=${D} ./install.sh || die
	rm -f ${D}/usr/lib/shorewall/firewall
	cp ${D}/etc/init.d/shorewall ${D}/usr/lib/shorewall/firewall
	rm -rf ${D}/etc/init.d
	
exeinto /etc/init.d
	newexe ${FILESDIR}/shorewall shorewall
}
pkg_postinst() {
	echo -e "\e[32;01m Read the documentatition from http://www.shorewall.net \033[0m"
	echo -e "\e[32;01m and edit the files in /etc/shorewall before starting the firewall \033[0m"
	echo
}
