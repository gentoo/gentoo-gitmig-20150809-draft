# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/openjade/openjade-1.3-r1.ebuild,v 1.8 2001/05/16 11:36:45 achim Exp $

P=openjade-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Jade is an implemetation of DSSSL - an ISO standard for formatting SGML (and XML) documents"
SRC_URI="http://download.sourceforge.net/openjade/"${A}
HOMEPAGE="http://openjade.sourceforge.net"

DEPEND="virtual/glibc
	sys-devel/perl"

RDEPEND="virtual/glibc
	app-text/sgml-common"


src_compile() {                           

  SGML_PREFIX=/usr/share/sgml
  try ./configure --host=${CHOST} --prefix=/usr \
	--enable-http \
	--enable-default-catalog=/etc/sgml/catalog \
	--enable-default-search-path=/usr/share/sgml \
	--datadir=/usr/share/sgml/${P}
  try make
}

src_install() {                               

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
  doins dsssl/builtins.dsl

  echo 'SYSTEM "builtins.dsl" "builtins.dsl"' > ${D}/usr/share/sgml/${P}/catalog
  insinto /usr/share/sgml/${P}/dsssl
  doins dsssl/{dsssl.dtd,style-sheet.dtd,fot.dtd}
  newins ${FILESDIR}/${P}.dsssl-catalog catalog
#  insinto /usr/share/sgml/${P}/unicode
#  doins unicode/{catalog,unicode.sd,unicode.syn}
  insinto /usr/share/sgml/${P}/pubtext
  doins pubtext/*

  dodoc COPYING NEWS README VERSION
  docinto html/doc
  dodoc doc/*.htm
  docinto html/jadedoc
  dodoc jadedoc/*.htm
  docinto html/jadedoc/images
  dodoc jadedoc/images/*

}

pkg_postinst() {
    install-catalog --add /etc/sgml/${P}.cat /usr/share/sgml/openjade-1.3/catalog
    install-catalog --add /etc/sgml/${P}.cat /usr/share/sgml/openjade-1.3/dsssl/catalog
    install-catalog --add /etc/sgml/${P}.cat /usr/share/sgml/openjade-1.3/unicode/catalog
    install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/${P}.cat
    echo
}

pkg_prerm() {
    if [ "$ROOT" ="/" ] ; then
    install-catalog --remove /etc/sgml/${P}.cat /usr/share/sgml/openjade-1.3/catalog
    install-catalog --remove /etc/sgml/${P}.cat /usr/share/sgml/openjade-1.3/dsssl/catalog
    install-catalog --remove /etc/sgml/${P}.cat /usr/share/sgml/openjade-1.3/unicode/catalog
    install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/${P}.cat
    fi
}


