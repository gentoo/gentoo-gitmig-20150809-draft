# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-tcp/ucspi-tcp-0.88-r1.ebuild,v 1.3 2002/07/14 19:20:19 aliz Exp $

DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/${PN}/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/${PN}/"
KEYWORDS="x86"
SLOT="0"
LICENSE="Freeware"
S=${WORKDIR}/${P}
DEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}
  cd ${S}
  echo "gcc ${CFLAGS}" > conf-cc
  echo "gcc" > conf-ld
  echo "/usr/" > conf-home
}

src_compile() {
  try pmake
}

src_install() {

  for i in tcpserver tcprules tcprulescheck argv0 recordio tcpclient *\@ tcpcat mconnect mconnect-io addcr delcr fixcrio rblsmtpd
  do
    dobin $i
  done

  dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}



