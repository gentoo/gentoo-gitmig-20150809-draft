# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-1.6.ebuild,v 1.1 2002/06/29 00:55:03 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Proxy DNS server"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${P}.tar.gz"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A} ; cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dosbin dnsmasq
	doman dnsmasq.8
	dodoc CHANGELOG COPYING FAQ
	dohtml *.html
	exeinto /etc/init.d
	newexe ${FILESDIR}/dnsmasq-init dnsmasq
	insinto /etc/conf.d
	newins ${FILESDIR}/dnsmasq.confd dnsmasq
}
