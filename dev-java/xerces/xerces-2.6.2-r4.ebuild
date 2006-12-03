# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.6.2-r4.ebuild,v 1.1 2006/12/03 03:04:24 caster Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="http://archive.apache.org/dist/xml/xerces-j/Xerces-J-src.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.6"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples source"

CDEPEND=">=dev-java/xml-commons-1.0_beta2
	>=dev-java/xml-commons-resolver-1.1"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5.2
	>=dev-java/xjavac-20041208
	source? ( app-arch/zip )
	${CDEPEND}"

S="${WORKDIR}/xerces-${PV//./_}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-javadoc.patch"

	mkdir tools && cd tools
	rm -f *.jar
	java-pkg_jar-from xml-commons xml-apis.jar
	java-pkg_jar-from xml-commons-resolver xml-commons-resolver.jar resolver.jar
}

src_compile() {
	eant -lib "$(java-pkg_getjars --build-only xjavac-1)" jar $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar build/xercesImpl.jar

	dodoc TODO STATUS README ISSUES
	java-pkg_dohtml Readme.html

	use doc && java-pkg_dojavadoc build/docs/javadocs
	if use examples; then
		dodir "/usr/share/doc/${PF}/examples"
		cp -r samples/* "${D}/usr/share/doc/${PF}/examples"
	fi
	use source && java-pkg_dosrc "${S}/src/org"
}
