# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.2.1-r1.ebuild,v 1.4 2006/12/09 09:09:32 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/dbcp/"
SRC_URI="mirror://apache/jakarta/commons/dbcp/source/${P}-src.tar.gz"
COMMON_DEP="
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.1"
RDEPEND=">=virtual/jre-1.3
		${COMMON_DEP}"
# FIXME doesn't like API changes with Java 1.6
DEPEND="|| (
			=virtual/jdk-1.3*
			=virtual/jdk-1.4*
			=virtual/jdk-1.5*
		)
		>=dev-java/ant-core-1.4
		${COMMON_DEP}
		source? ( app-arch/zip )"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

src_compile() {
	local antflags="build-jar"
	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" > build.properties
	echo "commons-pool.jar=$(java-pkg_getjars commons-pool)" >> build.properties
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt
	dohtml PROPOSAL.html STATUS.html
	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/*
}
