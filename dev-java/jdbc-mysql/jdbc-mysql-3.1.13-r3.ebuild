# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.1.13-r3.ebuild,v 1.1 2006/08/11 02:54:13 nichoj Exp $

inherit eutils java-pkg-2 java-ant-2

MY_PN="mysql-connector-java"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com/products/connector/j/"
SRC_URI="mirror://mysql/Downloads/Connector-J/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="c3p0 source"
COMMON_DEP="
	dev-java/log4j
	c3p0? ( dev-java/c3p0 )
	dev-java/jdbc2-stdext
	dev-java/commons-logging"
RDEPEND=">=virtual/jre-1.2
	${COMMON_DEP}"
# FIXME doesn't like Java 1.6's JDBC API
DEPEND="|| (
		=virtual/jdk-1.3*
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	${COMMON_DEP}
	sys-apps/sed
	dev-java/ant-core
	dev-java/junit
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar

	sed -i 's,{buildDir}/MANIFEST.MF,{buildDir}/META-INF/MANIFEST.MF,' build.xml || die "sed failed"

	mkdir src/lib-nodist # needed, or ant will fail
	cd src/lib
	rm -f *.jar
	java-pkg_jar-from jdbc2-stdext
	java-pkg_jar-from commons-logging
	java-pkg_jar-from junit
	java-pkg_jar-from log4j
	use c3p0 && java-pkg_jar-from c3p0
}

src_compile() {
	eant dist
}

src_install() {
	java-pkg_newjar build/${MY_P}/${MY_P}-bin.jar ${PN}.jar
	dodoc README CHANGES
	use source && java-pkg_dosrc src/com src/org
}
