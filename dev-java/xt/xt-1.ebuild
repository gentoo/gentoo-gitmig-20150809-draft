# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-1.ebuild,v 1.2 2000/11/01 06:27:08 achim Exp $

P=xt
A=${P}.zip
S=${WORKDIR}/${P}
DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="ftp://ftp.jclark.com/pub/xml/"${A}

DEPEND=">=dev-lang/jdk-1.2.2"

src_unpack() {
  mkdir ${S}
  cd ${S}
  jar -xf ${DISTDIR}/${A}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}
  insinto /opt/java/lib
  doins xt.jar sax.jar
  docinto html
  dodoc xt.htm
  docinto demo
  dodoc demo/*
}



