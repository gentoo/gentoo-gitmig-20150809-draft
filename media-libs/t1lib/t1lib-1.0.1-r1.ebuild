# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-1.0.1-r1.ebuild,v 1.1 2000/08/08 13:24:41 achim Exp $

P=t1lib-1.0.1
A=${P}.tar.gz
S=${WORKDIR}/T1-1.0.1
CATEGORY="media-libs"
DESCRIPTION="A Type 1 Rasterizer Library for UNIX/X11"
SRC_URI="ftp://ftp.neuroinformatik.ruhr-uni-bochum.de/pub/software/t1lib/"${A}
HOMEPAGE="http://www.neuroinformatik.ruhr-uni-bochum.de/ini/PEOPLE/rmz/t1lib/t1lib.html"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make without_doc
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr install
  dodoc Changes LGPL LICENSE README*
}



