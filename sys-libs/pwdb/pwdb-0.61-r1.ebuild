# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.61-r1.ebuild,v 1.4 2000/10/29 20:37:01 achim Exp $

P=pwdb-0.61
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Password Database"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/${A}"

src_unpack () {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}
src_compile() {                           
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/^DIRS = .*/DIRS = libpwdb/" Makefile.orig > Makefile
  try make
}

src_install() {                               
  cd ${S}
  into /usr
  dodir /usr/include/pwdb
  dodir /usr/lib
  dodoc doc/pwdb.txt CHANGES Copyright CREDITS README
  docinto html
  dodoc doc/html/*
  insinto /etc
  doins conf/pwdb.conf
  try make INCLUDED=${D}/usr/include/pwdb LIBDIR=${D}/usr/lib install
  preplib /usr
}




