# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/runset/runset-1.3-r1.ebuild,v 1.1 2000/08/06 13:36:58 achim Exp $

P=runset-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="app-admin"
DESCRIPTION="Runset Init suite, a replacement for sysv style initd"
SRC_URI="ftp://ftp.ocis.net/pub/users/ldeutsch/release/"${A}

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
  make prefix=${D}/usr install
  prepinfo
  dodoc AUTHORS COPYING INSTALL ChangeLog LSM NEWS README
  cp -a ${S}/sample ${D}/usr/doc/${P}
 
}




