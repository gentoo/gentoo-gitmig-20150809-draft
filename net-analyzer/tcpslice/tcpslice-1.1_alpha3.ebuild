# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpslice/tcpslice-1.1_alpha3.ebuild,v 1.1 2003/12/17 09:57:52 mboman Exp $

# Note: this ebuild is not of the best quality as it is entirely
# static. However I belive that I will get away with it as the software
# itself haven't been updated since 1996.

DESCRIPTION="Tcpslice is a program for extracting portions of packet-trace files generated using tcpdump's -w flag. It can also be used to glue together pcap dump files."
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/t/tcpslice/tcpslice_1.1a3.orig.tar.gz
	ftp://ftp.debian.org/debian/pool/main/t/tcpslice/tcpslice_1.1a3-1.1.diff.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc
	>=net-libs/libpcap-0.6.2-r1"

RDEPEND="${DEPEND}"
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
