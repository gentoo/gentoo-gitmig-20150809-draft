# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/djbdns/djbdns-1.02.ebuild,v 1.2 2001/01/01 18:45:15 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Excellent high-performance DNS services"
SRC_URI="http://cr.yp.to/djbdns/${A}"
HOMEPAGE="http://cr.yp.to/djbdns.html"

DEPEND=">=sys-libs/glibc-2.1.3 >=sys-apps/daemontools-0.70"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home
}

src_compile() {                           
	cd ${S}
	try pmake
}

src_install() {                               
	cd ${S}
	into /usr
	for i in *-conf dnscache tinydns walldns rbldns pickdns axfrdns *-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx dnsfilter random-ip dnsqr dnsq dnstrace 
	do
		dobin $i
	done
	insinto /etc
	doins dnsroots.global
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
	exeinto /etc/rc.d/init.d
	doexe ${FILESDIR}/dnscache
}



