# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.6.1.ebuild,v 1.1 2001/04/29 17:19:04 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="http://www.tcpdump.org/release/${A}
	 http://www.jp.tcpdump.org/release/${A}"
HOMEPAGE="http://www.tcpdump.org/"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	>=dev-libs/openssl-0.6.9
	>=net-libs/libpcap-0.6.1"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr
#--disable-ipv6
  try make
}

src_install() {                               
  into /usr
  dobin tcpdump
  doman tcpdump.1
  dodoc README FILES VERSION CHANGES
}



