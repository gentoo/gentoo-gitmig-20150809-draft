# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.38-r2.ebuild,v 1.2 2001/05/29 17:28:19 achim Exp $

P=ngrep-1.38
A=${P}.tar.gz
S=${WORKDIR}/ngrep
DESCRIPTION="A grep for network layers"
SRC_URI="http://ngrep.datasurge.net/"${A}
HOMEPAGE="http://ngrep.datasurge.net"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2"

RDEPEND="virtual/glibc"

src_unpack() {
  unpack ${A}
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
  
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {

  into /usr
  dobin ngrep
  doman ngrep.8
  dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}



