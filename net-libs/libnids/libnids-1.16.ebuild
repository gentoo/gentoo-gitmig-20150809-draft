# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.16.ebuild,v 1.12 2003/08/21 04:12:25 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libnids is an implementation of an E-component of Network Intrusion Detection System. It emulates the IP stack of Linux 2.0.x. Libnids offers IP defragmentation, TCP stream assembly and TCP port scan detection."
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P}.tar.gz"
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"

DEPEND="net-libs/libpcap
	=net-libs/libnet-1.0*"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc sparc ~alpha"

src_unpack () {
	unpack ${A}
        cd ${S}
        zcat ${FILESDIR}/libnids_gcc33_fix.gz | patch -p1
}

src_compile() {
	econf || die
	make || die
}

src_install () {

	make prefix=${D}/usr mandir=${D}/usr/share/man install

	dodoc CHANGES COPYING CREDITS MISC README

}
