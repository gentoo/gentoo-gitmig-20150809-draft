# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/openjade/openjade-1.3-r1.ebuild,v 1.5 2000/10/19 15:59:08 achim Exp $

P=openjade-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Jade is an implemetation of DSSSL - an ISO standard for formatting SGML (and XML) documents"
SRC_URI="http://download.sourceforge.net/openjade/"${A}
HOMEPAGE="http://openjade.sourceforge.net"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  SGML_PREFIX=/usr/share/sgml
  try ./configure --host=${CHOST} --prefix=/usr \
	--enable-http \
	--enable-default-catalog=/usr/share/sgml/${P}/catalog \
	--enable-default-search-path=/usr/share/sgml \
	--datadir=/usr/share/sgml/${P}
  try make
}

src_install() {                               
  cd ${S}
  dodir /usr
  dodir /usr/lib
  try make prefix=${D}/usr datadir=${D}/usr/share/sgml/${P} install
  dosym openjade  /usr/bin/jade
  dosym onsgmls   /usr/bin/nsgmls
  dosym osgmlnorm /usr/bin/sgmlnorm
  dosym ospam     /usr/bin/spam
  dosym ospent    /usr/bin/spent
  dosym osx 	  /usr/bin/sgml2xml

  insinto /usr/include/sp/generic
  doins generic/*.h

  insinto /usr/include/sp/include
  doins include/*.h

  insinto /usr/include/sp/lib
  doins lib/*.h


  insinto /usr/share/sgml/${P}/
  for i in catalog dsssl.dtd style-sheet.dtd fot.dtd
  do
    doins dsssl/$i
  done

#  for i in unicode dsssl pubtext
#  do
#    cp -af $i ${D}/usr/share/sgml/${P}
#  done

  dodoc COPYING NEWS README VERSION
  docinto html/doc
  dodoc doc/*.htm
  docinto html/jadedoc
  dodoc jadedoc/*.htm
  docinto html/jadedoc/images
  dodoc jadedoc/images/*

}




