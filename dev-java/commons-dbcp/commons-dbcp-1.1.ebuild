# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.1.ebuild,v 1.2 2004/04/05 05:45:02 zx Exp $

inherit java-pkg

DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/dbcp/"
SRC_URI="mirror://apache/jakarta/commons/dbcp/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.1"
RDEPEND=">=virtual/jre-1.3
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.1"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64"
IUSE="jikes doc"

src_compile() {
	local antflags="build-jar"
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-pool.jar=`java-config --classpath=commons-pool`" >> build.properties
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install () {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt
	dohtml PROPOSAL.html STATUS.html
	use doc && dohtml -r dist/docs/*
}
