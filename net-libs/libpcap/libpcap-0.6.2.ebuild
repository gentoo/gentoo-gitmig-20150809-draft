# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.6.2.ebuild,v 1.1 2001/12/06 06:02:18 woodchip Exp $

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
}

src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man install

	dodoc CREDITS CHANGES FILES README* VERSION
}
