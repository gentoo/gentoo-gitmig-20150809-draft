# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.0.1.ebuild,v 1.4 2002/08/01 18:27:30 karltk Exp $

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
SRC_URI="http://xml.apache.org/dist/xerces-j/Xerces-J-src.${PV}.tar.gz
	http://xml.apache.org/dist/xerces-j/Xerces-J-tools.${PV}.tar.gz"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"

DEPEND=">=virtual/jdk-1.3"
REDEPND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	mv tools ${S}
}

src_compile() {
	sh build.sh jars javadocs || die
}

src_install () {
	dojar build/xerces*.jar
	dodoc TODO STATUS README LICENSE ISSUES
	dohtml Readme.html

	dodir /usr/share/doc/${P}
	cp -a samples ${D}/usr/share/doc/${P}
	dohtml -r build/docs/javadocs
}

pkg_postinst() {
	einfo ">>> Documentation can be found at http://xml.apache.org/xerces2-j/index.html"
}
