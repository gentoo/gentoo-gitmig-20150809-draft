# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.2.1-r1.ebuild,v 1.7 2007/04/02 18:51:10 caster Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/dbcp/"
SRC_URI="mirror://apache/jakarta/commons/dbcp/source/${P}-src.tar.gz"
COMMON_DEP="
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.1"
RDEPEND=">=virtual/jre-1.4
		${COMMON_DEP}"
# FIXME doesn't like API changes with Java 1.6
DEPEND="|| (
			=virtual/jdk-1.5*
			=virtual/jdk-1.4*
		)
		${COMMON_DEP}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" > build.properties
	echo "commons-pool.jar=$(java-pkg_getjars commons-pool)" >> build.properties
	rm *.jar -v || die
}

EANT_BUILD_TARGET="build-jar"

src_install() {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt || die
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
