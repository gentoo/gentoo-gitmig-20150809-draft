# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-6.23.ebuild,v 1.2 2000/08/25 15:49:06 achim Exp $

P=ghostscript-6.23
A="${P}.tar.gz ghostscript-fonts-std-6.0.tar.gz"
A1=jpegsrc.v6b.tar.gz
A2=zlib-1.1.3.tar.gz
A3=libpng-1.0.6.tar.gz

S=${WORKDIR}/gs6.23
DESCRIPTION="Aladin Ghostscript"
SRC_URI="http://download.sourceforge.net/ghostscript/${P}.tar.gz
	 http://download.sourceforge.net/gs-fonts/ghostscript-fonts-std-6.0.tar.gz"

src_unpack() {
  unpack ${A}
  cd ${S}
  mkdir zlib
  cd zlib
  unpack ${A2}
  cd ..
  mkdir jpeg
  cd jpeg
  unpack ${A1}
  cd ..
  mkdir libpng
  cd libpng
  unpack ${A3}
  cd ../src
  cp ${O}/files/all-arch.mak all-arch.mak

}

src_compile() {                           
  cd ${S}/src
  cp all-arch.mak all-arch.mak.orig
  sed -e "s:^SRCDIR.*:SRCDIR = ${S}:" all-arch.mak.orig > all-arch.mak
  cp unix-gcc.mak unix-gcc.mak.orig
  sed    -e "s:-O2:${CFLAGS}:" unix-gcc.mak.orig > unix-gcc.mak
  cd ..
  make -f src/all-arch.mak linux prefix=/usr
}

src_install() {                               
  cd ${S}
  dobin bin/gs
  make -f src/all-arch.mak prefix=${D}/usr BINDIR=${D}/usr/bin install
  cd ${WORKDIR}
  cp -a fonts ${D}/usr/share/ghostscript
  cd ${S}

  prepman

  dodir /usr/doc/${PF}
  rm -rf ${D}/usr/share/ghostscript/6.23/doc
  dodoc doc/README doc/PUBLIC
  docinto html
  dodoc doc/*.html doc/*.htm
  insinto /usr/share/emacs/site-lisp
  doins doc/gsdoc.el

}




