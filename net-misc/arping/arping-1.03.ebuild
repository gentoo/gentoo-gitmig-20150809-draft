# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/arping/arping-1.03.ebuild,v 1.2 2002/03/19 04:14:53 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
SRC_URI="ftp://ftp.nss.nu/pub/synscan/${P}.tar.gz"
HOMEPAGE="http://synscan.nss.nu/programs.php"

DEPEND="net-libs/libpcap net-libs/libnet"

src_compile() {
	mv Makefile Makefile.orig
	sed "s/CFLAGS=-g/CFLAGS=${CFLAGS} -g/" Makefile.orig > Makefile || die
	make linux || die	
}

src_install () {
	dosbin arping
	doman arping.8
	dodoc LICENSE README
}
