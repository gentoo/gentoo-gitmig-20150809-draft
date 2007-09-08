# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-5.0.6.ebuild,v 1.5 2007/09/08 06:59:45 josejx Exp $

JAVA_PKG_IUSE="source"
WANT_ANT_TASKS="ant-contrib"

inherit eutils java-pkg-2 java-ant-2

MY_PN="mysql-connector-java"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com/products/connector/j/"
SRC_URI="mirror://mysql/Downloads/Connector-J/${MY_P}.tar.gz"
LICENSE="GPL-2-with-MySQL-FLOSS-exception"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 x86"
IUSE="c3p0 log4j"
COMMON_DEP="
	log4j? ( dev-java/log4j )
	c3p0? ( dev-java/c3p0 )
	dev-java/commons-logging"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# FIXME doesn't like Java 1.6's JDBC API
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# gcj hangs, but works for others -> why regexp over pictures?!
	epatch "${FILESDIR}/do-not-filter-png.diff"
	epatch "${FILESDIR}/5.0.5-remove-jboss-dependency-from-tests.patch"
	# http://bugs.mysql.com/bug.php?id=28286
	epatch "${FILESDIR}/5.0.5-dist-target-depends.patch"

	rm -v *.jar debug/*.jar || die

	java-ant_ignore-system-classes

	# use test && mkdir src/lib-nodist # needed, or ant will fail

	cd src/lib
	rm -v *.jar || die
	java-pkg_jar-from commons-logging
	use log4j && java-pkg_jar-from log4j
	use c3p0 && java-pkg_jar-from c3p0
}

EANT_BUILD_TARGET="dist"

# Tests need a mysql DB to exist
RESTRICT="test"
src_test() {
	cd src/lib
	java-pkg_jar-from junit
	cd "${S}"
	ANT_TASKS="ant-junit" eant test -Dcom.mysql.jdbc.noCleanBetweenCompiles=true
}

src_install() {
	java-pkg_newjar build/${MY_P}/${MY_P}-bin.jar ${PN}.jar
	dodoc README CHANGES || die
	dohtml docs/*.html || die
	use source && java-pkg_dosrc src/com src/org
}
