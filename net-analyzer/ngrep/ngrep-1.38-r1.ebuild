# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.38-r1.ebuild,v 1.1 2000/08/08 16:06:07 achim Exp $

P=ngrep-1.38
A=${P}.tar.gz
S=${WORKDIR}/ngrep
CATEGORY="net-analyzer"
DESCRIPTION="A grep for network layers"
SRC_URI="http://ngrep.datasurge.net/"${A}
HOMEPAGE="http://ngrep.datasurge.net"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  into /usr
  dobin ngrep
  doman ngrep.8
  dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}



