# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.6.1.ebuild,v 1.1 2001/04/29 17:11:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="pcap-Library"
SRC_URI="http://www.tcpdump.org/release/${A}
	 http://www.jp.tcpdump.org/release/${A}"

HOMEPAGE="http://www.tcpdump.org/"

DEPEND="virtual/glibc"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --enable-ipv6
  try make
}

src_install() {                               
  dodir /usr/share/man/man3
  try make prefix=${D}/usr mandir=${D}/usr/share/man install
  dodoc CREDITS CHANGES FILES README VERSION
}



