# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-1.3.1.ebuild,v 1.3 2004/10/17 19:22:44 axxo Exp $

inherit java-pkg

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="http://archive.apache.org/dist/xml/xerces-j/old_xerces1/Xerces-J-src.${PV}.tar.gz
	http://archive.apache.org/dist/xml/xerces-j/old_xerces1/Xerces-J-tools.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="1.3"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"


src_unpack() {
	unpack ${A}
	mv tmp/xml-xerces/java/tools ${S}
}

src_compile() {
	make jars || die "failed to compile"
	if use doc; then
		make docs || die "failed to create docs"
	fi
}

src_install () {
	java-pkg_dojar bin/x*.jar
	dodoc LICENSE README STATUS
	dohtml Readme.html

	if use doc; then
		java-pkg_dohtml -r docs/html/*
	fi
}
