# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Updated by AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.0.ebuild,v 1.3 2002/07/11 06:30:39 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="giflib"
SRC_URI="ftp://prtr-13.ucsc.edu/pub/libungif/"${A}
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

src_compile() {

  local myconf
  if [ "`use X`" ]
  then
    myconf="--with-x"
  else
    myconf="--without-x"
  fi

  ./configure --host=${CHOST} --prefix=/usr $myconf

  make
}

src_install() {

  make prefix=${D}/usr install
  if [ "`use gif`" ]
  then
    rm -rf ${D}/usr/bin
  fi

  dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS
  dodoc UNCOMPRESSED_GIF README TODO
  dodoc doc/*.txt
  docinto html
  dodoc doc/*.html doc/*.png
}

