# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.8.3-r1.ebuild,v 1.9 2004/04/05 07:10:50 vapier Exp $

inherit eutils

DESCRIPTION="pcap-Library"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa amd64 ia64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.8.1-fPIC.patch
}

src_compile() {
	econf `use_enable ipv6` || die "bad configure"
	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	gcc -Wl,-soname,libpcap.so.0 -shared -fPIC -o libpcap.so.${PV:0:3} *.o
	assert "couldn't make a shared lib"
}

src_install() {
	einstall || die

	insopts -m 755
	insinto /usr/lib ; doins libpcap.so.${PV:0:3}
	dosym /usr/lib/libpcap.so.${PV:0:3} /usr/lib/libpcap.so.0
	dosym /usr/lib/libpcap.so.${PV:0:3} /usr/lib/libpcap.so

	dodoc CREDITS CHANGES FILES README* VERSION
}
