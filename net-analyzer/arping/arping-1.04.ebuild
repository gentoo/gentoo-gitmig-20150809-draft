# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arping/arping-1.04.ebuild,v 1.4 2002/08/14 12:11:44 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
SRC_URI="ftp://ftp.habets.pp.se/pub/synscan/${P}.tar.gz"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=ARPing"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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
