# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arping/arping-2.01.ebuild,v 1.1 2003/08/21 04:36:29 vapier Exp $

DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=ARPing"
SRC_URI="ftp://ftp.habets.pp.se/pub/synscan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="net-libs/libpcap 
	>=net-libs/libnet-1.1.0-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/CFLAGS=-g/CFLAGS=-g ${CFLAGS}/" Makefile
}

src_compile() {
	make arping2 || die	
}

src_install() {
	newsbin arping arping2
	newman arping.8 arping2.8
	dodoc LICENSE README
}
