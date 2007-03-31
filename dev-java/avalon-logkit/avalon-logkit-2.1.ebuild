# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-2.1.ebuild,v 1.5 2007/03/31 20:35:50 opfer Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Easy-to-use Java logging toolkit"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/excalibur/excalibur-logkit/source/${P}-src.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 x86"
LICENSE="Apache-2.0"
SLOT="2.0"
IUSE="doc source test"

COMMON_DEP="
	dev-java/log4j
	dev-java/sun-jms
	dev-java/sun-javamail
	=dev-java/servletapi-2.4*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.3*
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	test? ( =dev-java/junit-3* dev-java/ant-tasks )
	source? ( app-arch/zip )
	dev-java/ant-core
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	xml-rewrite.py -f build.xml \
		-c -e available -a ignoresystemclasses -v "true" || die

	xml-rewrite.py -f build.xml	\
		-c -e available -a classpathref -v 'build.classpath' || die

	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from servletapi-2.4
	java-pkg_jar-from sun-jms
	java-pkg_jar-from sun-javamail
	java-pkg_jar-from log4j
}

src_test() {
	cd target/lib
	java-pkg_jar-from junit
	cd "${S}"
	eant test
}

src_install() {
	java-pkg_newjar target/*.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
