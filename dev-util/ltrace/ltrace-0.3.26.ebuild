# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ltrace/ltrace-0.3.26.ebuild,v 1.1 2002/06/06 09:07:22 doctomoe Exp $


S=${WORKDIR}/${P}
FILE_VERSION="ltrace_0.3.26"
DESCRIPTION="ltrace shows runtime library call information for dynamically linked executables"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/ltrace/${FILE_VERSION}.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/utils/ltrace.html"

DEPEND="virtual/glibc"

src_compile() {

  ./configure --prefix=/usr || die

  # modify CFLAGS (hopefully in a more time friendly way)
  mv Makefile Makefile.orig
  sed "s/ -O2 / ${CFLAGS} /" Makefile.orig > Makefile || die "sed failed... newer version of Makefile?"
  
  emake all || die

}

src_install() {

  make DESTDIR=${D} install || die

  # documentation
  rm -rvf ${D}usr/doc/
  dodoc BUGS COPYING debian/changelog README TODO

}
