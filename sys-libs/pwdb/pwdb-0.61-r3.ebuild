# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.61-r3.ebuild,v 1.1 2001/02/07 16:10:52 achim Exp $

P=pwdb-0.61
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Password Database"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/${A}"

DEPEND="virtual/glibc"

RDEPEND=$DEPEND

src_unpack () {

  mkdir ${S}
  cd ${S}
  unpack ${A}

}
src_compile() {

  cp Makefile Makefile.orig
  sed -e "s/^DIRS = .*/DIRS = libpwdb/" \
      -e "s:EXTRAS += :EXTRAS += ${CFLAGS} :" Makefile.orig > Makefile
  try make ${MAKEOPTS} 

}

src_install() {

  into /usr
  dodir /usr/include/pwdb
  dodir /lib

  try make INCLUDED=${D}/usr/include/pwdb LIBDIR=${D}/lib LDCONFIG="echo" install
  preplib /

  dodir /usr/lib
  mv ${D}/lib/*.a ${D}/usr/lib

  dodoc CHANGES Copyright CREDITS README
  docinto html
  dodoc doc/html/*
  docinto txt
  dodoc doc/*.txt

  insinto /etc
  doins conf/pwdb.conf


  cd ${O}/files
  insinto /etc/pam.d
  doins passwd
}




