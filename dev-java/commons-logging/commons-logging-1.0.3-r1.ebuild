# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-logging/commons-logging-1.0.3-r1.ebuild,v 1.2 2004/03/17 18:41:35 zx Exp $

inherit java-pkg

S="${WORKDIR}/${P}-src/"
DESCRIPTION="The Jakarta-Commons Logging package is an ultra-thin bridge between different logging libraries."
HOMEPAGE="http://jakarta.apache.org/commons/logging/"
SRC_URI="mirror://apache/jakarta/commons/logging/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	dev-java/avalon-logkit
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc jikes junit"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "log4j.jar=`java-config -p log4j`" > build.properties
	echo "logkit.jar=`java-config -p avalon-logkit`" >> build.properties
	echo "junit.jar=`java-config -p junit`" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar target/${PN}-api.jar target/${PN}.jar

	dodoc RELEASE-NOTES.txt
	dohtml PROPOSAL.html STATUS.html usersguide.html
	use doc && dohtml -r dist/docs/
}
