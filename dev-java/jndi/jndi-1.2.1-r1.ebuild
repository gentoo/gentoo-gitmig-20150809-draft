# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jndi/jndi-1.2.1-r1.ebuild,v 1.1 2000/08/07 17:43:40 achim Exp $

P=jndi-1.2.1
A=jndi1_2_1.zip
S=${WORKDIR}/${P}
CATEGORY="dev-java"
DESCRIPTION="Java Naming and Directory Interface"
SRC_URI="ftp://"${A}
HOMEPAGE="http://java.sun.com/products/jndi/"

#Please download the sources from sun

src_unpack() {
  mkdir ${S}
  cd ${S}
  unzip ${DISTDIR}/${A}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}
  insinto /opt/java/lib
  doins lib/jndi.jar
  dodoc COPYRIGHT README.txt 
  docinto html
  dodoc doc/*.html
}



