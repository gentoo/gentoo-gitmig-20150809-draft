# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.0.1-r1.ebuild,v 1.2 2001/02/13 14:29:40 achim Exp

S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="ftp://freetype.sourceforge.net/pub/freetype/freetype2/${P}.tar.bz2"
HOMEPAGE="http://www.freetype.org/"

DEPEND="virtual/glibc"

src_unpack() {

  unpack ${P}.tar.bz2
  cd ${S}
  cp ${FILESDIR}/config.mk .

}
src_compile() {

  cd builds/unix
  try ./configure --prefix=/usr
  cd ${S}
  export CFG="--host=${CHOST} --prefix=/usr"
  #try make
  try make

}

src_install() {

  try make prefix=${D}/usr install

  dodoc CHANGES LICENSE.TXT
  dodoc docs/*.txt

  docinto html
  dodoc docs/*.html

  local i 
  for i in design glyphs image tutorial
  do
    docinto html/${i}
    dodoc docs/${i}/*
  done

}





