# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libPropList/libPropList-0.10.1-r2.ebuild,v 1.1 2001/03/09 10:26:59 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/release/srcs/current/${A}"
HOMEPAGE="http://www.windowmaker.org/"

DEPEND="virtual/glibc"

src_compile() {                           

  try ./configure --host=${CHOST} --prefix=/usr
  try make

}

src_install() {                               

  try make prefix=${D}/usr install

  dodoc AUTHORS COPYING* ChangeLog README TODO

}




