# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/daemontools/daemontools-0.70-r1.ebuild,v 1.3 2001/02/27 23:03:15 achim Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/daemontools/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/daemontools.html"

DEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}

  cd ${S}
  patch -p1 < ${FILESDIR}/${P}-tai64nlocal-gentoo.diff
  echo "gcc ${CFLAGS}" > conf-cc
  echo "gcc" > conf-ld
  echo "${D}/usr" > conf-home

}

src_compile() {

  try pmake
}

src_install() {

  dodir /usr
  try ./install
  
  dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION

}



