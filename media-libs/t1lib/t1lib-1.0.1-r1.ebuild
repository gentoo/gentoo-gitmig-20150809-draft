# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-1.0.1-r1.ebuild,v 1.5 2000/11/02 02:17:12 achim Exp $

P=t1lib-1.0.1
A=${P}.tar.gz
S=${WORKDIR}/T1-1.0.1
DESCRIPTION="A Type 1 Rasterizer Library for UNIX/X11"
SRC_URI="ftp://ftp.neuroinformatik.ruhr-uni-bochum.de/pub/software/t1lib/"${A}
HOMEPAGE="http://www.neuroinformatik.ruhr-uni-bochum.de/ini/PEOPLE/rmz/t1lib/t1lib.html"

DEPEND=">=sys-libs/glibc-2.1.3
	>=app-text/tetex-1.0.7
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
   try make
#  try make without_doc
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc Changes LGPL LICENSE README*
}



