# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-6.23-r2.ebuild,v 1.1 2000/10/29 20:36:59 achim Exp $

P=ghostscript-6.23
A="${P}.tar.gz ghostscript-fonts-std-6.0.tar.gz print-4.0.0rc1.tar.gz"
A1=jpegsrc.v6b.tar.gz
A2=zlib-1.1.3.tar.gz
A3=libpng-1.0.8.tar.gz

S=${WORKDIR}/gs6.23
DESCRIPTION="Aladin Ghostscript"
SRC_URI="http://download.sourceforge.net/ghostscript/${P}.tar.gz
	 http://download.sourceforge.net/gs-fonts/ghostscript-fonts-std-6.0.tar.gz
	 http://download.sourceforge.net/gimp-print/print-4.0.0rc1.tar.gz"

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
  cd ${WORKDIR}/print-4.0.0rc1/Ghost
  cp *.c *.h ${S}/src
  cat contrib.mak.addon >> ${S}/src/contrib.mak
  cd ${S}/src
  cp unix-gcc.mak unix-gcc.mak.orig
  sed -e "s:^DEVICE_DEVS6=:DEVICE_DEVS6=\$\(DD\)stp\.dev :" \
	unix-gcc.mak.orig > unix-gcc.mak  
}

src_compile() {                           
  cd ${S}/src
  cp all-arch.mak all-arch.mak.orig
  sed -e "s:^SRCDIR.*:SRCDIR = ${S}:" all-arch.mak.orig > all-arch.mak
  cp unix-gcc.mak unix-gcc.mak.orig
  sed    -e "s:-O2:${CFLAGS}:" unix-gcc.mak.orig > unix-gcc.mak
  cd ..
  try make -f src/all-arch.mak linux prefix=/usr
  cd ${WORKDIR}/print-4.0.0rc1/Ghost
  try make
}

src_install() {                               
  cd ${S}
  dobin bin/gs
  try make -f src/all-arch.mak prefix=${D}/usr BINDIR=${D}/usr/bin install
  cd ${WORKDIR}
  cp -a fonts ${D}/usr/share/ghostscript
  cd ${S}

  dodir /usr/doc/${PF}
  rm -rf ${D}/usr/share/ghostscript/6.23/doc
  dodoc doc/README doc/PUBLIC
  docinto html
  dodoc doc/*.html doc/*.htm
  insinto /usr/share/emacs/site-lisp
  doins doc/gsdoc.el

  cd ${WORKDIR}/print-4.0.0rc1/Ghost
  dobin escputil
  docinto stp
  dodoc README* COPYING ChangeLog
  cp -a stp-interface ${D}/usr/doc/${P}/stp
}




