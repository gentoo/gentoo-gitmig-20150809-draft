# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-1.8.3-r1.ebuild,v 1.5 2000/11/01 04:44:17 achim Exp $

P=libgd-1.8.3
A=gd-1.8.3.tar.gz
S=${WORKDIR}/gd-1.8.3
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/"${A}
HOMEPAGE="http://www.boutell.com/gd/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.7
	>=media-libs/freetype-1.3.1
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s/^CFLAGS=.*/CFLAGS=$CFLAGS -DHAVE_XPM -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
      -e "s/^LIBS=.*/LIBS=-lm -lgd -lpng -lz -ljpeg -lttf -lXpm -lX11/" \
      -e "s/^INCLUDEDIRS=/INCLUDEDIRS=-I\/usr\/include\/freetype /" \
	Makefile.orig > Makefile
}

src_compile() {                           
  cd ${S}
  try make
}

src_install() {                               
  cd ${S}
  dodir /usr/bin
  dodir /usr/lib
  dodir /usr/include
  try make INSTALL_LIB=${D}/usr/lib INSTALL_BIN=${D}/usr/bin \
	INSTALL_INCLUDE=${D}/usr/include install
  preplib /usr
  dodoc readme.txt
  docinto html
  dodoc index.html
}





