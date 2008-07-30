# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/hibernate/hibernate-3.1.3-r1.ebuild,v 1.1 2008/07/30 18:58:25 betelgeuse Exp $

EAPI=1
WANT_ANT_TASKS="ant-antlr ant-swing ant-junit"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PV="3.1"
DESCRIPTION="Hibernate is a powerful, ultra-high performance object / relational persistence and query service for Java."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.hibernate.org"
LICENSE="LGPL-2"
IUSE=""
SLOT="3.1"
KEYWORDS="~x86 ~amd64"

COMMON_DEPEND="
	dev-java/antlr:0
	dev-java/c3p0:0
	dev-java/cglib:2.2
	dev-java/commons-collections:0
	dev-java/commons-logging:0
	dev-java/dom4j:1
	dev-java/ehcache:0
	dev-java/oscache:0
	dev-java/proxool:0
	dev-java/swarmcache:1.0
	dev-java/jta:0
	dev-java/sun-jacc-api:0
	dev-java/ant-core:0
	dev-java/asm:2.2"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
# FIXME doesn't like  Java 1.6's JDBC API
DEPEND="|| (
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	${COMMON_DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# this depends on jboss
	rm src/org/hibernate/cache/JndiBoundTreeCacheProvider.java \
		src/org/hibernate/cache/TreeCache.java \
		src/org/hibernate/cache/TreeCacheProvider.java

	rm -v *.jar lib/*.jar || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="
c3p0,commons-collections,commons-logging,cglib-2.2,jta
dom4j-1,ehcache,oscache,proxool,swarmcache-1.0
sun-jacc-api,antlr,ant-core,asm-2.2
"
EANT_EXTRA_ARGS="-Dnosplash -Ddist.dir=dist"

src_install() {
	java-pkg_dojar hibernate3.jar
	dodoc changelog.txt readme.txt
	use doc && java-pkg_dohtml -r dist/doc/api doc/other doc/reference
	use source && java-pkg_dosrc src/*
}
