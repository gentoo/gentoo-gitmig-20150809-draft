# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.5.2.ebuild,v 1.4 2000/12/08 17:21:49 achim Exp $

P=tcpdump-3.5.2
A=${P}.tar.gz
S=${WORKDIR}/tcpdump-3.5
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="http://www.tcpdump.org/release/${A}
	 http://www.jp.tcpdump.org/release/${A}"
HOMEPAGE="http://www.tcpdump.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/zlib-1.1.3
	>=net-libs/libpcap-0.5.2"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --disable-ipv6
  try make
}

src_install() {                               
  cd ${S}
  into /usr
  dobin tcpdump
  doman tcpdump.1
  dodoc README FILES VERSION CHANGES
}



