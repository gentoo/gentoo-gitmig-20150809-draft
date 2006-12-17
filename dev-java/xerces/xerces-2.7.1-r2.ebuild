# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.7.1-r2.ebuild,v 1.4 2006/12/17 16:18:37 dertobi123 Exp $

inherit  eutils versionator java-pkg-2 java-ant-2

DIST_PN="Xerces-J"
SRC_PV="$(replace_all_version_separators _ )"
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="mirror://apache/xml/${PN}-j/${DIST_PN}-src.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ppc ppc64 x86"
IUSE="doc examples source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/xml-commons-external-1.3*
	>=dev-java/xml-commons-resolver-1.1"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6.5-r14
	>=dev-java/xjavac-20041208
	source? ( app-arch/zip )
	${RDEPEND}"

S="${WORKDIR}/${PN}-${SRC_PV}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-no_dom3.patch

	mkdir tools && cd tools
	java-pkg_jar-from xml-commons-external-1.3 xml-apis.jar
	java-pkg_jar-from xml-commons-resolver xml-commons-resolver.jar resolver.jar
}

src_compile() {
	eant -lib "$(java-pkg_getjars --build-only xjavac-1)" jar $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar build/xercesImpl.jar

	dodoc TODO STATUS README ISSUES
	java-pkg_dohtml Readme.html

	use doc && java-pkg_dohtml -r build/docs/javadocs
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r samples/* ${D}/usr/share/doc/${PF}/examples
	fi

	use source && java-pkg_dosrc ${S}/src/org
}
