## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Updated by AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.0-r3.ebuild,v 1.1 2001/05/07 20:08:03 aj Exp $

P=giflib-4.1.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="giflib"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/libs/giflib/${A}
	 ftp://prtr-13.ucsc.edu/pub/libungif/${A}"

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

  try ./configure --host=${CHOST} --prefix=/usr ${myconf}

  try make

}

src_install() {

  try make prefix=${D}/usr install
  if [ "`use ungif`" ]
  then
    rm -rf ${D}/usr/bin
  fi

  dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS ONEWS
  dodoc PATENT_PROBLEMS README TODO
  dodoc doc/*.txt
  docinto html
  dodoc doc/*.html doc/*.png

}



