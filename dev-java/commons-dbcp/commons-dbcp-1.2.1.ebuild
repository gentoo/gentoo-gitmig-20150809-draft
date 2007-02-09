# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.2.1.ebuild,v 1.12 2007/02/09 21:35:35 nelchael Exp $

inherit java-pkg

DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/dbcp/"
SRC_URI="mirror://apache/jakarta/commons/dbcp/source/${P}-src.tar.gz"
RDEPEND=">=virtual/jre-1.4
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.1"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-core-1.4
		${RDEPEND}
		source? ( app-arch/zip )
		jikes? ( dev-java/jikes )"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc amd64 ppc64"
IUSE="jikes doc source"

src_compile() {
	local antflags="build-jar"
	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" > build.properties
	echo "commons-pool.jar=$(java-pkg_getjars commons-pool)" >> build.properties
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt
	dohtml PROPOSAL.html STATUS.html
	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/*
}
