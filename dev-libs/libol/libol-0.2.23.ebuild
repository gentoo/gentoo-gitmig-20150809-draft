# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce Locke <blocke@shivan.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Support library for syslog-ng"
SRC_URI="http://www.balabit.hu/downloads/libol/0.2/${A}"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"

#DEPEND=">="

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr --enable-shared --enable-static --disable-libtool-lock
  try make CFLAGS=\"${CFLAGS}\" ${MAKEOPTS} prefix=${D}/usr all

}

src_install() {

  try make prefix=${D}/usr install 
  dodoc ChangeLog 

}



