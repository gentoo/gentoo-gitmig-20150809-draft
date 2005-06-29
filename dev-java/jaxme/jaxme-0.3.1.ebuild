# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxme/jaxme-0.3.1.ebuild,v 1.1 2005/06/29 18:31:59 axxo Exp $

inherit java-pkg eutils

MY_PN=ws-${PN}
MY_P=${MY_PN}-${PV}
DESCRIPTION="JaxMe 2 is an open source implementation of JAXB, the specification for Java/XML binding."
HOMEPAGE="http://ws.apache.org/jaxme/index.html"
SRC_URI="http://mirrors.combose.com/apache/ws/jaxme/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	dev-db/hsqldb
	=dev-java/xerces-2*
	dev-java/xmldb"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	dev-java/junit
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix the build.xml so we can build jars and javadoc easily
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/prerequisites
	rm *.jar
	java-pkg_jarfrom hsqldb hsqldb.jar hsqldb-1.7.1.jar
	java-pkg_jarfrom junit
	java-pkg_jarfrom log4j log4j.jar log4j-1.2.8.jar
	java-pkg_jarfrom xerces-2
	java-pkg_jarfrom xmldb xmldb-api.jar xmldb-api-20021118.jar
	java-pkg_jarfrom xmldb xmldb-api-sdk.jar xmldb-api-sdk-20021118.jar
}

src_compile() {
	local antflags="jar"
#	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} -Dbuild.apidocs=dist/doc/api javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	dodoc NOTICE

	use doc && java-pkg_dohtml -r dist/doc/api src/documentation/manual
	use source && java-pkg_dosrc src/*/*
}
