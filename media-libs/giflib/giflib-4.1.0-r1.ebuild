## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.0-r1.ebuild,v 1.3 2000/09/15 20:09:01 drobbins Exp $

P=giflib-4.1.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="giflib"
SRC_URI="ftp://prtr-13.ucsc.edu/pub/libungif/"${A}
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"
src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS ONEWS
  dodoc PATENT_PROBLEMS README TODO
  dodoc doc/*.txt
  docinto html
  dodoc doc/*.html doc/*.png
}



