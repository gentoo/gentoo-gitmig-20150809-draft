# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpcre/libpcre-3.4-r1.ebuild,v 1.1 2001/03/06 06:20:41 achim Exp $

A=pcre-${PV}.tar.gz
S=${WORKDIR}/pcre-${PV}
DESCRIPTION="Perl compatible regular expressions"
SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/"${A}

DEPEND="virtual/glibc"

src_compile() {                           

  try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
  try make
}

src_install() {                               

  try make DESTDIR=${D} install

  dodoc AUTHORS COPYING ChangeLog LICENCE NEWS NON-UNIX-USE README
  dodoc doc/*.txt doc/Tech.Notes
  docinto html
  dodoc doc/*.html
  
}




