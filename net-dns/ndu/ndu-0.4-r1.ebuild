# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ndu/ndu-0.4-r1.ebuild,v 1.2 2004/07/19 09:43:28 dholm Exp $

DESCRIPTION="DNS serial number incrementer and reverse zone builder"
URI_BASE="http://uranus.it.swin.edu.au/~jn/linux/"
SRC_URI="${URI_BASE}/${P}.tar.gz"
HOMEPAGE="${URI_BASE}/dns.htm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="sys-apps/sed virtual/libc"
RDEPEND="virtual/libc"

src_compile() {
	cd ${S}/src
	sed -i 's|gcc|$(CXX)|g' Makefile
	sed -i 's|#define CONFIG_PATH "/etc/"|#define CONFIG_PATH "/etc/bind/"|g' ndc.c
	emake
	sed -i 's|VISUAL|EDITOR|g' dnsedit
	cd ${S}
	sed -i 's|0.0.127.in-addr.arpa|127.in-addr.arpa|g' ndu.conf
	echo '## if you use a chrooted setup, then you need to uncomment these lines:' >>ndu.conf
	echo '#process "/chroot/dns/named.conf"' >>ndu.conf
	echo '#chroot "/chroot/dns"' >>ndu.conf
}

src_install () {
	into /usr
	dosbin src/{dnsedit,ndu}
	dobin src/dnstouch
	into /
	insinto /etc/bind
	doins ndu.conf
	dodoc README INSTALL
}
