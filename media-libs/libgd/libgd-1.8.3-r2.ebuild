# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-1.8.3-r2.ebuild,v 1.5 2001/08/15 11:51:58 hallski Exp $

P=libgd-1.8.3
A=gd-1.8.3.tar.gz
S=${WORKDIR}/gd-1.8.3
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://www.boutell.com/gd/http/"${A}
HOMEPAGE="http://www.boutell.com/gd/"

DEPEND="virtual/glibc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.7
	~media-libs/freetype-1.3.1
	X? ( virtual/x11 )"

src_unpack() {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  if [ "`use X`" ]
  then
    sed -e "s/^CFLAGS=.*/CFLAGS=$CFLAGS -DHAVE_XPM -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
      -e "s/^LIBS=.*/LIBS=-lm -lgd -lpng -lz -ljpeg -lttf -lXpm -lX11/" \
      -e "s/^INCLUDEDIRS=/INCLUDEDIRS=-I\/usr\/include\/freetype /" \
	Makefile.orig > Makefile
  else
    sed -e "s/^CFLAGS=.*/CFLAGS=$CFLAGS -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
      -e "s/^LIBS=.*/LIBS=-lm -lgd -lpng -lz -ljpeg -lttf/" \
      -e "s/^INCLUDEDIRS=/INCLUDEDIRS=-I\/usr\/include\/freetype /" \
	Makefile.orig > Makefile
  fi

}

src_compile() {

  try make

}

src_install() {

  dodir /usr/{bin,lib,include}

  try make INSTALL_LIB=${D}/usr/lib INSTALL_BIN=${D}/usr/bin \
	INSTALL_INCLUDE=${D}/usr/include install

  preplib /usr
  dodoc readme.txt
  docinto html
  dodoc index.html

}





