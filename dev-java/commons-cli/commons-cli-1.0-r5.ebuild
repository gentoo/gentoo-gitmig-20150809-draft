# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0-r5.ebuild,v 1.5 2006/12/07 22:34:34 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="The CLI library provides a simple and easy to use API for working with the command line arguments and options."
HOMEPAGE="http://jakarta.apache.org/commons/cli/"
SRC_URI="mirror://apache/jakarta/commons/cli/source/cli-${PV}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc junit source"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-logging-1.0
	=dev-java/commons-lang-2.0*"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	junit? ( >=dev-java/junit-3.7  >=dev-java/ant-tasks-1.6.2 )
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.6.2"

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
	use junit && antflags="${antflags} test"
	eant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	dodoc README.txt
	use doc && java-pkg_dohtml -r target/docs/
	use source && java-pkg_dosrc src/java/*
}

