# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.3.0-r1.ebuild,v 1.1 2003/05/26 09:36:45 absinthe Exp $

inherit java-pkg

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
SRC_URI="http://xml.apache.org/dist/xerces-j/Xerces-J-src.${PV}.tar.gz
	http://xml.apache.org/dist/xerces-j/Xerces-J-tools.${PV}.tar.gz"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
DEPEND=">=dev-java/ant-1.5.2"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha"
IUSE="doc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	mv tools ${S}
}

src_compile() {
	if [ -n "`use doc`" ] ; then
		sh build.sh jar sampjar javadocs || die "Compile failed."
	else
		sh build.sh jar sampjar || die "Compile failed."
	fi
}

src_install () {
	java-pkg_dojar build/x*.jar
	dodoc TODO STATUS README LICENSE ISSUES 
	dohtml Readme.html

	if [ -n "`use doc`" ] ; then
		dodir /usr/share/doc/${P}
		cp -a samples ${D}/usr/share/doc/${P}
		dohtml -r build/docs/javadocs
	fi
}
