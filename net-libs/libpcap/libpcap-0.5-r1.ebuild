# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpcap/libpcap-0.5-r1.ebuild,v 1.3 2000/09/15 20:09:10 drobbins Exp $

P=libpcap-0.5
A=${P}.tar.gz
S=${WORKDIR}/libpcap_0_5rel2
DESCRIPTION="pcap-Library"
SRC_URI="http://www.tcpdump.org/release/${A}
	 http://www.jp.tcpdump.org/release/${A}"

HOMEPAGE="http://www.tcpdump.org/"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --enable-ipv6
  try make
}

src_install() {                               
  cd ${S}
  dodir /usr/lib
  dodir /usr/include/net
  dodir /usr/man/man3
  try make prefix=${D}/usr install
  try make prefix=${D}/usr install-incl
  try make prefix=${D}/usr install-man
  prepman
  dodoc CREDITS CHANGES FILES README VERSION
}



