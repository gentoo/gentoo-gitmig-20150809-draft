# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.7.1.ebuild,v 1.1 2002/05/11 22:31:37 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="pcap-Library"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"
HOMEPAGE="http://www.tcpdump.org/"

DEPEND="virtual/glibc"

src_compile() {

	local myconf
	use ipv6 && myconf="--enable-ipv6"

	./configure \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--host=${CHOST} ${myconf} || die "bad configure"

	emake || die "compile problem"

	# no provision for this in the Makefile, so...
	gcc -Wl,-soname,libpcap.so.0 -shared -fpic -o libpcap.so.0.6 *.o
	assert "couldn't make a shared lib"
}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man install

	insopts -m 755
	insinto /usr/lib ; doins libpcap.so.0.6
	dosym /usr/lib/libpcap.so.0.6 /usr/lib/libpcap.so.0
	dosym /usr/lib/libpcap.so.0.6 /usr/lib/libpcap.so

	dodoc CREDITS CHANGES FILES README* VERSION
}
