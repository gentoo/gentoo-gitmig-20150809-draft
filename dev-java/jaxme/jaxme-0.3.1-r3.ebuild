# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxme/jaxme-0.3.1-r3.ebuild,v 1.3 2006/12/09 09:19:55 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PN=ws-${PN}
MY_P=${MY_PN}-${PV}
DESCRIPTION="JaxMe 2 is an open source implementation of JAXB, the specification for Java/XML binding."
HOMEPAGE="http://ws.apache.org/jaxme/index.html"
SRC_URI="http://mirrors.combose.com/apache/ws/jaxme/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

COMMON_DEP="
	dev-db/hsqldb
	>=dev-java/xerces-2.7
	dev-java/junit
	dev-java/gnu-crypto
	>=dev-java/log4j-1.2.8
	dev-java/xmldb"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# FIXME doesn't like to compile with Java 1.6
DEPEND="|| (
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	dev-java/ant-core
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

# We do it later
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix the build.xml so we can build jars and javadoc easily
	epatch ${FILESDIR}/${P}-gentoo.patch
	# Use gnu-crypto instead of com.sun.* stuff
	epatch ${FILESDIR}/${P}-base64.diff

	cd ${S}/prerequisites
	rm *.jar
	java-pkg_jarfrom hsqldb hsqldb.jar hsqldb-1.7.1.jar
	java-pkg_jarfrom junit
	java-pkg_jarfrom log4j log4j.jar log4j-1.2.8.jar
	java-pkg_jarfrom gnu-crypto gnu-crypto.jar
	java-pkg_jarfrom xerces-2
	java-pkg_jarfrom xmldb xmldb-api.jar xmldb-api-20021118.jar
	java-pkg_jarfrom xmldb xmldb-api-sdk.jar xmldb-api-sdk-20021118.jar

	# Bad build system, should be fixed to use properties
	java-pkg_jarfrom ant-core ant.jar ant-1.5.4.jar
	java-pkg_jarfrom ant-core ant.jar ant.jar

	# Special case: jaxme uses build<foo>.xml files, so rewriting them by hand
	# is better:
	cd ${S}
	for i in build*.xml src/webapp/build.xml src/test/jaxb/build.xml; do
		java-ant_bsfix_one "${i}"
	done
}

src_compile() {
	eant $(use_doc -Dbuild.apidocs=dist/doc/api javadoc) jar
}

src_install() {
	java-pkg_dojar dist/*.jar

	dodoc NOTICE

	use doc && java-pkg_dohtml -r dist/doc/api src/documentation/manual
	use source && java-pkg_dosrc src/*/*
}
