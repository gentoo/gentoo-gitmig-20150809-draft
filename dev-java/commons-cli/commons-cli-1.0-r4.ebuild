# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0-r4.ebuild,v 1.10 2005/07/12 11:44:16 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="The CLI library provides a simple and easy to use API for working with the command line arguments and options."
HOMEPAGE="http://jakarta.apache.org/commons/cli/"
SRC_URI="mirror://apache/jakarta/commons/cli/source/cli-${PV}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 sparc ppc amd64 ppc64"
IUSE="doc jikes junit source"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-logging-1.0
	>=dev-java/commons-lang-1.0"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	junit? ( >=dev-java/junit-3.7 )
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )
	>=dev-java/ant-1.6.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.diff
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging	commons-logging.jar)" >> build.properties
	echo "commons-lang.jar=$(java-pkg_getjars commons-lang)" >> build.properties
	use junit && echo "junit.jar=$(java-pkg_getjars junit)" >> build.properties
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	dodoc README.txt
	use doc && java-pkg_dohtml -r target/docs/
	use source && java-pkg_dosrc src/java/*
}

