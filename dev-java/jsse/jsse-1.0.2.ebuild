# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsse/jsse-1.0.2.ebuild,v 1.1 2001/07/10 01:34:16 achim Exp $

A=jsse-1_0_2-gl.zip
S=${WORKDIR}/jsse1.0.2
DESCRIPTION="Java API for XML parsing"
SRC_URI="ftp://${A}"
HOMEPAGE="http://java.sun.com/products/jsse/"

# Get the global version !

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
  doins lib/*.jar
  dodoc *.txt 
  docinto html
  dodoc *.html
  mv doc ${D}/usr/share/doc/${PF}/html/
}



