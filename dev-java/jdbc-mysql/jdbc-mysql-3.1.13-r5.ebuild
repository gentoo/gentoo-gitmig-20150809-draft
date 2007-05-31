# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.1.13-r5.ebuild,v 1.2 2007/05/31 15:49:29 opfer Exp $

JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

MY_PN="mysql-connector-java"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com/products/connector/j/"
SRC_URI="mirror://mysql/Downloads/Connector-J/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE="c3p0 test"
COMMON_DEP="
	dev-java/log4j
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
	epatch ${FILESDIR}/do-not-filter-png.diff
	# com.sun.* classes are used during testing
	! use test && epatch ${FILESDIR}/no-testsuite.diff
	rm -v *.jar || die

	sed -i 's,{buildDir}/MANIFEST.MF,{buildDir}/META-INF/MANIFEST.MF,' build.xml || die "sed failed"

	mkdir src/lib-nodist # needed, or ant will fail
	cd src/lib
	rm -v *.jar || die
	java-pkg_jar-from commons-logging
	java-pkg_jar-from log4j
	use c3p0 && java-pkg_jar-from c3p0
}

EANT_BUILD_TARGET="dist"

#TODO add src_test

src_install() {
	java-pkg_newjar build/${MY_P}/${MY_P}-bin.jar ${PN}.jar
	dodoc README CHANGES || die
	use source && java-pkg_dosrc src/com src/org
}
