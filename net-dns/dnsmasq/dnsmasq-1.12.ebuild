# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-1.12.ebuild,v 1.2 2003/05/11 03:43:36 avenj Exp $

DESCRIPTION="Proxy DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"

SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${P}.tar.gz"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

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
