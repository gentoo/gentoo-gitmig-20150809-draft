# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/runset/runset-1.4.ebuild,v 1.2 2001/11/10 02:30:19 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Runset Init suite, a replacement for sysv style initd"
SRC_URI="ftp://ftp.ocis.net/pub/users/ldeutsch/release/${P}.tar.gz"

DEPEND="virtual/glibc"


src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr --infodir=/usr/share/info
  try make
}

src_install() {

  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING INSTALL ChangeLog LSM NEWS README
  cp -a ${S}/sample ${D}/usr/share/doc/${PF}
 
}





