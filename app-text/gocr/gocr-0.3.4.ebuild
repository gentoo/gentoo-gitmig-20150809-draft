# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.3.4.ebuild,v 1.1 2001/11/06 13:41:47 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Converts PNM to ASCII"
SRC_URI="http://prdownloads.sourceforge.net/jocr/${A}"
HOMEPAGE="http://altmark.nat.uni-magdeburg.de/~jschulen/ocr/"

DEPEND="virtual/glibc
        app-text/tetex
        app-text/ghostscript
        >=media-libs/netpbm-9.12-r1"

RDEPEND="virtual/glibc
        >=media-libs/netpbm-9.12-r1"

src_unpack() {

  unpack ${A}
  patch -p0 < ${FILESDIR}/${P}-gentoo.diff
  cd ${S}
  autoconf
  cd ${S}/doc
  cp Makefile.in Makefile.orig
  sed -e "s:\$(DVIPS) \$?:\$(DVIPS) -o \$(OCRDOC).ps \$?:" \
    Makefile.orig > Makefile.in
  cd ../bin
  mv gocr.tcl gocr.orig
  sed -e "s:\.\./examples:/usr/share/gocr/fonts:" \
    gocr.orig > gocr.tcl
  cd ../src
  cp database.c database.orig
  sed -e "s:\./db/:/usr/share/gocr/db/:" database.orig > database.c
  cd ../examples
  cp Makefile Makefile.orig
  sed -e "s:polish.pbm man.pbm:polish.pbm:" Makefile.orig > Makefile

}

src_compile() {

    try CFLAGS="$CFLAGS -I/usr/include/pbm" ./configure --prefix=/usr --host=${CHOST}
    try make src frontend database
    if [ "`use tex`" ]
    then
      try make doc
    fi

}

src_install () {

    dobin bin/gocr
    exeinto /usr/bin
    doexe bin/gocr.tcl
    dolib.a src/libPgm2asc.a
    insinto /usr/include
    doins src/gocr.h
    insinto /usr/share/gocr/db
    doins db/*
    doman man/man1/gocr.1
    dodoc AUTHORS BUGS CREDITS HISTORY README* REMARK.txt REVIEW TODO gpl.html
    docinto txt
    dodoc doc/*.txt
    if [ "`use tex`" ]
    then 
      insinto /usr/share/gocr/db
      docinto ps
      dodoc doc/ocr.ps
    fi

}

