# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.61-r2.ebuild,v 1.3 2000/12/24 09:55:16 achim Exp $

P=pwdb-0.61
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Password Database"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/${A}"

DEPEND=">=sys-libs/glibc-2.1.3"

RDEPEND=$DEPEND

src_unpack () {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}
src_compile() {                           
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/^DIRS = .*/DIRS = libpwdb/" Makefile.orig > Makefile
  try make ${MAKEOPTS}
}

src_install() {                               
  cd ${S}
  into /usr
  dodir /usr/include/pwdb
  dodir /lib
  dodoc CHANGES Copyright CREDITS README
  docinto html
  dodoc doc/html/*
  docinto txt
  dodoc doc/*.txt
  insinto /etc
  doins conf/pwdb.conf
  try make INCLUDED=${D}/usr/include/pwdb LIBDIR=${D}/lib LDCONFIG="echo" install
  preplib /

  cd ${O}/files
  insinto /etc/pam.d
  doins passwd
}




