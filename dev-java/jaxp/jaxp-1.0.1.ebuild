# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.0.1.ebuild,v 1.1 2001/04/22 18:06:04 achim Exp $

A=jaxp-1_0_1.zip
S=${WORKDIR}/jaxp1.0.1
DESCRIPTION="Java API for XML parsing"
SRC_URI="ftp://${A}"
HOMEPAGE="http://java.sun.com/products/jndi/"

DEPEND=">=dev-lang/jdk-1.3.0
	>=app-arch/unzip-5.41"
RDEPEND=">=dev-lang/jdk-1.3.0"

#Please download the sources from sun

src_unpack() {
  jar -xf ${DISTDIR}/${A}
}

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}
  insinto /usr/lib/java
  doins jaxp.jar parser.jar
  dodoc LICENSE 
  docinto html
  dodoc *.html
  mv docs ${D}/usr/share/doc/${PF}/html/
}



