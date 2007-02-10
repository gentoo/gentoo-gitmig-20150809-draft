# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/c3p0/c3p0-0.9.0.4.ebuild,v 1.6 2007/02/10 18:56:48 nixnut Exp $

inherit java-pkg-2 java-ant-2

SRC_P="${P}.src"

DESCRIPTION="Library for augmenting traditional (DriverManager-based) JDBC drivers with JNDI-bindable DataSources"
HOMEPAGE="http://c3p0.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${SRC_P}.tgz"
# Does not like Java 1.6's JDBC API
COMMON_DEPEND="dev-java/log4j"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.5* )
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc source"

S="${WORKDIR}/${SRC_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	echo "j2ee.jar.base.dir=${JAVA_HOME}" > build.properties
	echo "log4j.jar.file=$(java-pkg_getjar log4j log4j.jar)" >> build.properties
}

src_compile() {
	eant jar $(use_doc javadocs)
}

src_install() {
	java-pkg_newjar build/${P}.jar
	dodoc README-SRC
	use doc && java-pkg_dojavadoc build/apidocs
	use source && java-pkg_dosrc src/classes/com
}
