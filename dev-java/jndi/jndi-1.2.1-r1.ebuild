# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jndi/jndi-1.2.1-r1.ebuild,v 1.4 2000/11/02 08:31:50 achim Exp $

P=jndi-1.2.1
A=jndi1_2_1.zip
S=${WORKDIR}/${P}
DESCRIPTION="Java Naming and Directory Interface"
SRC_URI="ftp://"${A}
HOMEPAGE="http://java.sun.com/products/jndi/"

DEPEND=">=dev-lang/jdk-1.2.2"

#Please download the sources from sun

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
  insinto /usr/lib/java
  doins lib/jndi.jar
  dodoc COPYRIGHT README.txt 
  docinto html
  dodoc doc/*.html
}



