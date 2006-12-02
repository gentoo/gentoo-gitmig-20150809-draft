# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/castor/castor-1.0.5.ebuild,v 1.1 2006/12/02 16:24:46 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Data binding framework for Java"
HOMEPAGE="http://www.castor.org"
SRC_URI="http://dist.codehaus.org/${PN}/${PV}/${P}-src.tgz"

#SRC_URI="mirror://gentoo/${P}.tar.bz2"
# svn co https://svn.codehaus.org/castor/castor/tags/1.0.3/ castor-1.0.3
# cd castor-1.0.3
# mvn ant:ant
# do some magic to build.xml
# rm lib/*
# cd ../
# tar cjvf castor-1.0.3.tar.bz2 --exclude=.svn castor-1.0.3

LICENSE="Exolab"
SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

# tests and full documentation when support will be added
#	dev-java/log4j
#	~dev-java/servletapi-2.4
#	dev-java/junit"

COMMON_DEPS="=dev-java/adaptx-0.9*
	=dev-java/cglib-2.0*
	dev-java/commons-logging
	=dev-java/jakarta-oro-2.0*
	=dev-java/jakarta-regexp-1.3*
	dev-java/jta
	=dev-java/ldapsdk-4.1*
	dev-java/ant-core"

# Does not like Java 1.6's JDBC API
DEPEND="|| (
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	source? ( app-arch/zip )
	${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPS}"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"
	rm -v *.jar tests/*.jar
	java-pkg_jar-from cglib-2 cglib.jar
	java-pkg_jar-from commons-logging commons-logging-api.jar
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from jakarta-regexp-1.3
	java-pkg_jar-from jta
	java-pkg_jar-from ldapsdk-4.1 ldapjdk.jar
	java-pkg_jar-from ant-core ant.jar

	# These are only used for tests or documentation
	#java-pkg_jar-from junit
	#java-pkg_jar-from adaptx-0.9
	#java-pkg_jar-from log4j
	#java-pkg_jar-from servletapi-2.4 servlet-api.jar
}

src_compile() {
	cd "${S}"/src/
	eant clean jar $(use_doc)
}

# Needs for example mockejb which is not packaged yet
#src_test() {
#	cd "${S}"/src/
#	eant tests
#}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar
	java-pkg_newjar dist/${P}-commons.jar ${PN}-commons.jar
	java-pkg_newjar dist/${P}-xml.jar ${PN}-xml.jar
	use source && java-pkg_dosrc src/main/java/org
	use doc && java-pkg_dojavadoc build/doc/javadoc
}
