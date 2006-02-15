# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arping/arping-1.06-r1.ebuild,v 1.11 2006/02/15 21:51:15 jokey Exp $

inherit eutils

DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=ARPing"
SRC_URI="ftp://ftp.habets.pp.se/pub/synscan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="net-libs/libpcap
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
	sed -i "s/CFLAGS=-g/CFLAGS=-g ${CFLAGS}/" Makefile
}

src_compile() {
	make linux || die
}

src_install() {
	newsbin arping arping1
	newman arping.8 arping1.8
	dodoc LICENSE README
}
