# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.1.4.ebuild,v 1.1 2000/08/25 15:10:23 achim Exp $

P=libsdl-1.1.4
A=SDL-1.1.4.tar.gz
S=${WORKDIR}/SDL-1.1.4
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/"${A}
HOMEPAGE="http://www.libsdl.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install

  dodoc BUGS COPYING CREDITS README* TODO WhatsNew
  docinto html
  dodoc *.html
  docinto html/docs
  dodoc docs/*.html
  for i in audio cdrom events images opengl threads time video
  do
    docinto html/docs/$i
    dodoc docs/$i/*
  done
  
}




