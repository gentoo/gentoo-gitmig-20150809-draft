# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.16.ebuild,v 1.3 2002/07/17 06:28:54 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libnids is an implementation of an E-component of Network Intrusion Detection System. It emulates the IP stack of Linux 2.0.x. Libnids offers IP defragmentation, TCP stream assembly and TCP port scan detection."
SRC_URI="http://www.packetfactory.net/Projects/Libnids/dist/${P}.tar.gz"
HOMEPAGE="http://www.packetfactory.net/Projects/Libnids/"

DEPEND="net-libs/libpcap net-libs/libnet"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

src_compile() {
	
	econf || die
	make || die
}

src_install () {

	make prefix=${D}/usr mandir=${D}/usr/share/man install

	dodoc CHANGES COPYING CREDITS MISC README

}
