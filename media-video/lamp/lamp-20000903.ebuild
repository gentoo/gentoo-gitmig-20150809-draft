# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/lamp/lamp-20000903.ebuild,v 1.3 2000/09/15 20:09:05 drobbins Exp $

P=lamp-2000.09.03
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Video Player for mpeg2/3, avi and quicktime movie"
SRC_URI="http://pauillac.inria.fr/lamp/src/${A}"
HOMEPAGE="http://pauillac.inria.fr/lamp/"

src_unpack () {

  WIN32=/usr/libexec/avifile/win32
  unpack ${A}
  cd ${S}
  sed -e "s:-g:${CFLAGS}:" ${FILESDIR}/Makefile.config > ${S}/Makefile.config


  cd players/avifile-0.46.1

  mv configure configure.orig
  sed -e "s:/usr/lib/win32:$WIN32:" configure.orig > configure

  cd lib/loader
  mv Makefile Makefile.orig
  sed -e "s:/usr/lib/win32:$WIN32:" Makefile.orig > Makefile

  mv elfdll.c elfdll.c.orig
  sed -e "s:/usr/lib/win32:$WIN32:" elfdll.c.orig > elfdll.c

  cd ../audiodecoder

  mv audiodecoder.cpp audiodecoder.cpp.orig
  sed -e "s:/usr/lib/win32:$WIN32:" audiodecoder.cpp.orig > audiodecoder.cpp

  cd ../../xmps-avi-plugin

  mv Makefile Makefile.orig
  sed -e "s:/usr/lib/win32:$WIN32:" Makefile.orig > Makefile

  cd ../player

  mv mywidget.cpp mywidget.cpp.orig
  sed -e "s:/usr/lib/win32:$WIN32:" mywidget.cpp.orig > mywidget.cpp

  cd ../..

  mv lampavi.c lampavi.c.orig
  sed -e "s:/usr/lib/win32:$WIN32:" lampavi.c.orig > lampavi.c


}

src_compile() {

    cd ${S}
    unset CFLAGS
    try make depend
    try make world

}

src_install () {

    cd ${S}
    try make installroot=${D} install
    rmdir ${D}/usr/libexec/lamp/avifile_codecs
    cp ${FILESDIR}/config ${D}/usr/libexec/lamp
    dodoc ANNOUNCE ChangeLog COPYING CREDITS README* TODO USAGE FAQ docs/Xv.txt
    docinto html
    dodoc docs/*.html
    
}



