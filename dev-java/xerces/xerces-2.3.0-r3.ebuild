# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.3.0-r3.ebuild,v 1.6 2008/01/17 14:39:12 caster Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="http://xml.apache.org/dist/xerces-j/Xerces-J-src.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.3
	>=dev-java/xml-commons-1.0_beta2"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/xjavac-20041208-r1
	${RDEPEND}"

S=${WORKDIR}/xerces-${PV//./_}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gentoo.patch"

	mkdir tools && cd tools
	java-pkg_jar-from xml-commons xml-apis.jar
}

src_compile() {
	ANT_TASKS="xjavac-1" eant jar $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar build/xercesImpl.jar

	dodoc TODO STATUS README ISSUES || die
	dohtml Readme.html || die

	use doc && java-pkg_dojavadoc build/docs/javadocs/xerces2
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc "${S}/src/org"
}
