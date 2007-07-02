# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpslice/tcpslice-1.1_alpha3.ebuild,v 1.12 2007/07/02 14:43:23 peper Exp $

inherit eutils

# Note: this ebuild is not of the best quality as it is entirely
# static. However I believe that I will get away with it as the software
# itself haven't been updated since 1996.

DESCRIPTION="Tcpslice is a program for extracting portions of packet-trace files generated using tcpdump's -w flag. It can also be used to glue together pcap dump files."
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="mirror://debian/pool/main/t/tcpslice/tcpslice_1.1a3.orig.tar.gz
	mirror://debian/pool/main/t/tcpslice/tcpslice_1.1a3-1.1.diff.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="virtual/libc
	net-libs/libpcap"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/tcpslice-1.1a3

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/tcpslice_1.1a3-1.1.diff.gz
	cd ${S}
	sed -i -e 's:net/bpf.h:pcap-bpf.h:g' tcpslice.c || die
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
