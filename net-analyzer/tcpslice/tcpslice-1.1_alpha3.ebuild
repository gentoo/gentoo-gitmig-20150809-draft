# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpslice/tcpslice-1.1_alpha3.ebuild,v 1.7 2004/07/10 11:19:37 eldad Exp $

inherit eutils

# Note: this ebuild is not of the best quality as it is entirely
# static. However I believe that I will get away with it as the software
# itself haven't been updated since 1996.

DESCRIPTION="Tcpslice is a program for extracting portions of packet-trace files generated using tcpdump's -w flag. It can also be used to glue together pcap dump files."
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="mirror://debian/pool/main/t/tcpslice/tcpslice_1.1a3.orig.tar.gz
	mirror://debian/pool/main/t/tcpslice/tcpslice_1.1a3-1.1.diff.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/libc
	>=net-libs/libpcap-0.6.2-r1"

S=${WORKDIR}/tcpslice-1.1a3

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/tcpslice_1.1a3-1.1.diff.gz
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dosbin tcpslice
	doman tcpslice.1
	dodoc README
}
