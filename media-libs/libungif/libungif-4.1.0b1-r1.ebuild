# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.0b1-r1.ebuild,v 1.2 2000/08/16 04:38:08 drobbins Exp $

P=libungif-4.1.0b1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="giflib"
SRC_URI="ftp://prtr-13.ucsc.edu/pub/libungif/"${A}
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr install
  dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS
  dodoc UNCOMPRESSED_GIF README TODO
  dodoc doc/*.txt
  docinto html
  dodoc doc/*.html doc/*.png
}





