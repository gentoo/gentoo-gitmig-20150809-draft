# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxp/jaxp-1.1.ebuild,v 1.1 2001/11/04 23:29:45 hallski Exp $

S=${WORKDIR}/jaxp-1.1
DESCRIPTION="Java API for XML parsing"
SRC_URI="ftp://jaxp-1_1.zip"
HOMEPAGE="http://java.sun.com/xml/"

DEPEND=">=dev-lang/jdk-1.3.0
	>=app-arch/unzip-5.41"
RDEPEND=">=dev-lang/jdk-1.3.0"

# Please download the sources from sun
# http://java.sun.com/xml/download.html

src_unpack() {
	jar -xf ${DISTDIR}/${A}
}

src_compile() {                           
	cd ${S}
}

src_install() {                               
	cd ${S}
	insinto /opt/java/jre/lib/ext
	doins jaxp.jar crimson.jar xalan.jar
	dodoc LICENSE
	docinto html
	dodoc *.html
	mv docs ${D}/usr/share/doc/${PF}/html/
}



