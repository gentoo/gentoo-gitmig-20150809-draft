# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/djbdns/djbdns-1.05-r1.ebuild,v 1.1 2002/03/02 02:33:19 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Excellent high-performance DNS services"
SRC_URI="http://cr.yp.to/djbdns/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/djbdns.html"

DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/daemontools-0.70"

src_compile() {                           
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home
	emake || die "emake failed"
}

src_install() {                               
	insinto /etc
	doins dnsroots.global
	into /usr
	for i in *-conf dnscache tinydns walldns rbldns pickdns axfrdns *-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx dnsfilter random-ip dnsqr dnsq dnstrace dnstracesort
	do
		dobin $i
	done
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
