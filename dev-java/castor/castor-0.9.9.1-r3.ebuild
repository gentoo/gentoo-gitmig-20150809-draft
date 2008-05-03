# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/castor/castor-0.9.9.1-r3.ebuild,v 1.3 2008/05/03 19:07:31 opfer Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Data binding framework for Java"
SRC_URI="http://dist.codehaus.org/${PN}/${PV}/${P}-src.tgz"
HOMEPAGE="http://www.castor.org"
LICENSE="Exolab"
KEYWORDS="amd64 x86"
SLOT="0.9"
IUSE="doc examples"

COMMON_DEP="
	dev-java/adaptx:0.9
	>=dev-java/commons-logging-1.0.4
	dev-java/jakarta-oro:2.0
	dev-java/jakarta-regexp:1.3
	dev-java/ldapsdk:4.1
	java-virtuals/servlet-api:2.3
	dev-java/xerces:1.3
	dev-java/cglib:2"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# Does not like Java 1.6's JDBC API
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# TODO this should be filed upstream
	epatch "${FILESDIR}/0.9.5.3-jikes.patch"

	cd "${S}/lib"
	rm -f *.jar
	java-pkg_jar-from --build-only ant-core ant.jar
	java-pkg_jar-from adaptx-0.9
	java-pkg_jar-from commons-logging
	java-pkg_jar-from cglib-2
	java-pkg_jar-from jakarta-oro-2.0 jakarta-oro.jar oro.jar
	java-pkg_jar-from jakarta-regexp-1.3 jakarta-regexp.jar regexp.jar
	java-pkg_jar-from --virtual servlet-api-2.3
	java-pkg_jar-from xerces-1.3
	java-pkg_jar-from ldapsdk-4.1 ldapjdk.jar
}

src_compile() {
	cd "${S}/src"
	eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar dist/${P}.jar
	java-pkg_newjar dist/${P}-xml.jar ${PN}-xml.jar

	use doc && java-pkg_dojavadoc build/doc/javadoc
	use examples && java-pkg_doexamples src/examples
	use source && java-pkg_dosrc src/main/org
}
