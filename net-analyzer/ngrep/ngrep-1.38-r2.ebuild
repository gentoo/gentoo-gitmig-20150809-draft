# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.38-r2.ebuild,v 1.1 2001/04/29 15:05:06 achim Exp $

P=ngrep-1.38
A=${P}.tar.gz
S=${WORKDIR}/ngrep
DESCRIPTION="A grep for network layers"
SRC_URI="http://ngrep.datasurge.net/"${A}
HOMEPAGE="http://ngrep.datasurge.net"

DEPEND=">=sys-libs/glibc-2.1.3
	>=net-libs/libpcap-0.5.2"

src_unpack() {
  unpack ${A}
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  into /usr
  dobin ngrep
  doman ngrep.8
  dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}



