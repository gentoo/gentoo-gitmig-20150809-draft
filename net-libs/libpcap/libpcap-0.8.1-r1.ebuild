# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.8.1-r1.ebuild,v 1.1 2004/02/15 13:41:04 mboman Exp $

S=${WORKDIR}/${P}
DESCRIPTION="pcap-Library"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"
HOMEPAGE="http://www.tcpdump.org/"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="BSD"
IUSE="ipv6"
KEYWORDS="~x86 ~ppc sparc ~alpha ~mips hppa ~arm ~amd64 ~ia64"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	econf `use_enable ipv6` || die "bad configure"
	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	gcc -Wl,-soname,libpcap.so.0 -shared -fPIC -o libpcap.so.0.8 *.o
	assert "couldn't make a shared lib"
}

src_install() {
	einstall || die

	insopts -m 755
	insinto /usr/lib ; doins libpcap.so.0.8
	dosym /usr/lib/libpcap.so.0.8 /usr/lib/libpcap.so.0
	dosym /usr/lib/libpcap.so.0.8 /usr/lib/libpcap.so
	into /usr/include/net
	dosym /usr/include/pcap-bpf.h /usr/include/net/bpf.h

	dodoc CREDITS CHANGES FILES README* VERSION LICENSE
}
