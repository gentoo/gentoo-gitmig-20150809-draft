# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a free replacement for Tripwire"
SRC_URI="http://www.cs.tut.fi/~rammer/${P}.tar.gz"
HOMEPAGE="http://www.cs.tut.fi/~rammer/aide.html"

DEPEND="sys-apps/gzip sys-devel/bison sys-devel/flex"

src_compile() {

  # aide 0.7 refuses to compile with postgresql support (missing headerfile?)
  # postgres USE keyword disabled for now... :(

  #if [ -z "`use postgres`" ] ; then
	try ./configure --prefix=/usr --with-zlib 
	try make CFLAGS=\"$CFLAGS\" all
  #else
  #	try ./configure --prefix=/usr --with-zlib --with-psql
  #	try make CFLAGS=\"$CFLAGS -I/usr/include/postgresql\" all
  #fi

}

src_install() {

  try make prefix=${D}/usr mandir=${D}/usr/share/man  install

  dodir /etc
  cp ${S}/doc/aide.conf ${D}/etc

  dodoc AUTHORS COPYING INSTALL NEWS README doc/manual.html

}

