# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/killproc/killproc-1.12-r2.ebuild,v 1.2 2001/11/10 02:30:19 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="killproc and assorted tools for boot scripts"
SRC_URI="ftp://ftp.suse.com/pub/projects/init/${P}.tar.gz"

DEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/-O2/${CFLAGS}/" -e "s/-m486//" Makefile.orig > Makefile

}

src_compile() {
  try make
}

src_install() {

  into /
  dosbin checkproc startproc killproc
  into /usr
  doman *.8
  dodoc README *.lsm
  
}




