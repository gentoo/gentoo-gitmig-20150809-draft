# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/netwib/netwib-5.9.0.ebuild,v 1.2 2004/03/21 13:14:10 mboman Exp $

DESCRIPTION="Library of Ethernet, IP, UDP, TCP, ICMP, ARP and RARP protocols"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwib/"
SRC_URI="http://www.laurentconstantin.com/common/netw/netwib/download/v${PV/.*}/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.1"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}/src

	sed -i \
		-e 's:-ansi::' \
		-e 's:/usr/local:/usr:g' \
		-e "s:-O2:${CFLAGS}:" \
		genemake config.dat
	./genemake || die "problem creating Makefile"
}

src_compile() {
	cd src
	emake || die "compile problem"
}

src_install() {
	dodoc README.TXT doc/*.txt
	cd src
	emake install DESTDIR=${D} || die
}
