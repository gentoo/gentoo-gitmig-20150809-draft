# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.0.1.ebuild,v 1.3 2001/01/05 03:21:55 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="ftp://freetype.sourceforge.net/pub/freetype/freetype2/"${A}
HOMEPAGE="http://www.freetype.org/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
  cd ${S}
  export CFG="--host=${CHOST} --prefix=/usr"
  try make
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc CHANGES LICENSE.TXT
  dodoc docs/*.txt 
  docinto html
  dodoc docs/*.html
  for i in design glyphs image tutorial
  do
    docinto html/${i}
    dodoc docs/${i}/*
  done

}





