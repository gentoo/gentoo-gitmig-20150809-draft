# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-1.0.1-r2.ebuild,v 1.3 2001/05/01 18:29:06 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/T1-${PV}
DESCRIPTION="A Type 1 Rasterizer Library for UNIX/X11"
SRC_URI="ftp://ftp.neuroinformatik.ruhr-uni-bochum.de/pub/software/t1lib/${A}"
HOMEPAGE="http://www.neuroinformatik.ruhr-uni-bochum.de/ini/PEOPLE/rmz/t1lib/t1lib.html"

DEPEND="virtual/glibc
	tetex? ( >=app-text/tetex-1.0.7 )
	X? ( virtual/x11 )"

src_compile() {

  local myconf
  if [ "`use X`" ]
  then
    myconf="--with-x"
  else
    myconf="--without-x"
  fi

  try ./configure --host=${CHOST} --prefix=/usr --datadir=/etc ${myconf}

  if [ "`use tetex`" ]
  then
     try make
  else
     try make without_doc
  fi

}

src_install() {

  cd lib
  insinto /usr/include
  doins t1lib.h

  if [ "`use X`" ]
  then

    doins t1libx.h
    dolib .libs/libt1x.{la,a,so.1.0.1}
    dosym libt1x.so.1.0.1 /usr/lib/libt1x.so.1
    dosym libt1x.so.1.0.1 /usr/lib/libt1x.so
  fi
  dolib .libs/libt1.{la,a,so.1.0.1}
  dosym libt1.so.1.0.1 /usr/lib/libt1.so.1
  dosym libt1.so.1.0.1 /usr/lib/libt1.so
  insinto /etc/t1lib
  doins t1lib.config

  cd ..
  dodoc Changes LGPL LICENSE README*

}



