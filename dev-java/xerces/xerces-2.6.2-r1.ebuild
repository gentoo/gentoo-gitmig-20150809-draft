# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.6.2-r1.ebuild,v 1.10 2004/10/21 19:19:14 axxo Exp $

inherit java-pkg eutils

IUSE="doc"

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="mirror://apache/xml/xerces-j/Xerces-J-src.${PV}.tar.gz
	mirror://apache/xml/xerces-j/Xerces-J-tools.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="x86 ppc sparc amd64"

DEPEND=">=dev-java/ant-core-1.5.2"
RDEPEND=">=virtual/jdk-1.3"

src_unpack() {
	unpack ${A}
	mv tools ${S}
}

src_compile() {
	addpredict /dev/random
	if use doc ; then
		sh build.sh jars sampjar javadocs || die "Compile failed."
	else
		sh build.sh jars sampjar || die "Compile failed."
	fi
}

src_install() {
	java-pkg_dojar build/x*.jar
	dodoc TODO STATUS README ISSUES
	dohtml Readme.html

	if use doc ; then
		dodir /usr/share/doc/${P}
		cp -a samples ${D}/usr/share/doc/${PF}
		java-pkg_dohtml -r build/docs/javadocs
	fi
}

pkg_postinst() {
	if use doc ; then
		einfo "                                                          "
		einfo " API Documentation is in /usr/share/doc/${PN}-${PV}.      "
		einfo "                                                          "
		einfo " Online Documentation:                                    "
		einfo "     http://xml.apache.org/xerces2-j/api.html             "
		einfo "                                                          "
		epause 5
	else
		einfo "                                                          "
		einfo " Online Documentation:                                    "
		einfo "     http://xml.apache.org/xerces2-j/api.html             "
		einfo "                                                          "
		epause 5
	fi
}

