# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/angst/angst-0.4b.ebuild,v 1.5 2003/09/05 23:40:08 msterret Exp $

IUSE=""
DESCRIPTION="Angst is an active sniffer. It provides methods for aggressive sniffing on switched LANs."
HOMEPAGE="http://angst.sourceforge.net"
SRC_URI="http://angst.sourceforge.net/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=net-libs/libpcap-0.7.1
	=net-libs/libnet-1.0*"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P}"

src_compile() {
	make CFLAGS="${CFLAGS}" -f Makefile.linux || die
}

src_install() {
	into /usr
	dosbin angst
	doman angst.8
	dodoc README LICENSE TODO ChangeLog
}

