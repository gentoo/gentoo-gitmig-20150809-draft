# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.6.0.ebuild,v 1.7 2004/02/19 03:52:47 strider Exp $

inherit java-pkg eutils

IUSE="doc"

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="mirror://apache/xml/xerces-j/Xerces-J-src.${PV}.tar.gz
	mirror://apache/xml/xerces-j/Xerces-J-tools.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND=">=dev-java/ant-1.5.2"
RDEPEND=">=virtual/jdk-1.3"

src_unpack() {
	unpack ${A}
	mv tools ${S}
}

src_compile() {
	addpredict /dev/random
	if [ -n "`use doc`" ] ; then
		sh build.sh jars sampjar javadocs || die "Compile failed."
	else
		sh build.sh jars sampjar || die "Compile failed."
	fi
}

src_install() {
	java-pkg_dojar build/x*.jar
	dodoc TODO STATUS README LICENSE ISSUES
	dohtml Readme.html

	if [ -n "`use doc`" ] ; then
		dodir /usr/share/doc/${P}
		cp -a samples ${D}/usr/share/doc/${P}
		dohtml -r build/docs/javadocs
	fi
}

pkg_postinst() {
	if [ -n "`use doc`" ] ; then
		einfo "                                                          "
		einfo " API Documentation is in /usr/share/doc/${PN}-${PV}.      "
		einfo "                                                          "
		einfo " Online Documentation:                                    "
		einfo "     http://xml.apache.org/xerces2-j/api.html             "
		einfo "                                                          "
		sleep 5
	else
		einfo "                                                          "
		einfo " Online Documentation:                                    "
		einfo "     http://xml.apache.org/xerces2-j/api.html             "
		einfo "                                                          "
		sleep 5
	fi
}

