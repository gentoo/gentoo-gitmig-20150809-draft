# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arping/arping-1.06.ebuild,v 1.4 2003/09/05 23:40:08 msterret Exp $

DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=ARPing"
SRC_URI="ftp://ftp.habets.pp.se/pub/synscan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"

DEPEND="net-libs/libpcap
	=net-libs/libnet-1.0*"

src_compile() {
	mv Makefile Makefile.orig
	sed "s/CFLAGS=-g/CFLAGS=${CFLAGS} -g/" Makefile.orig > Makefile || die
	make linux || die
}

src_install() {
	dosbin arping
	doman arping.8
	dodoc LICENSE README
}
