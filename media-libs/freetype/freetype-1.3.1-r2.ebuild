# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-1.3.1-r2.ebuild,v 1.2 2001/02/22 14:41:18 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="ftp://ftp.freetype.org/pub/freetype1/${A}"
HOMEPAGE="http://www.freetype.org/"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_compile() {

  local myconf

  if [ -z "`use nls`" ]
  then
    myconf="${myconf} --disable-nls"
  fi

  try ./configure --host=${CHOST} --prefix=/usr ${myconf}

  # Make a small fix to disable tests
  # Now xfree is no longer required
  cp Makefile Makefile.orig
  sed -e "s:ttlib tttest ttpo:ttlib ttpo:" Makefile.orig > Makefile

  try make

}

src_install() {

  cd lib

  # Seems to require a shared libintl (getetxt comes only with a static one
  # But it seems to work without problems

  try make -f arch/unix/Makefile prefix=${D}/usr install
  cd ../po
  try make prefix=${D}/usr install
  cd ..
  dodoc announce PATENTS README readme.1st
  dodoc docs/*.txt docs/FAQ docs/TODO
  docinto html
  dodoc docs/*.htm
  docinto html/image
  dodoc docs/image/*.gif docs/image/*.png

}




