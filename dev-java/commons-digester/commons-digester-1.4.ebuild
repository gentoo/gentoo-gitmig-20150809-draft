# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-digester/commons-digester-1.4.ebuild,v 1.1 2004/11/16 12:25:02 karltk Exp $

inherit java-pkg

DESCRIPTION="Jarkata Digester component, XML to Java bindings for configuration"
HOMEPAGE="http://jakarta.apache.org/commons/digester/"
SRC_URI="mirror://apache/jakarta/commons/digester/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
SLOT="0"

IUSE="doc jikes junit"
RDEPEND=">=virtual/jre-1.3
	 >=dev-java/commons-beanutils-1.4
	 >=dev-java/commons-collections-2.0
	 >=dev-java/commons-logging-1.0"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.3
	>=dev-java/ant-1.4
	junit? ( >=dev-java/junit-3.7 )"

S=${WORKDIR}/${P}-src

src_compile() {
	local antflags="all"

	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test -Djunit.jar=`java-config -p junit`"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	antflags="${antflags} -Dcommons-beanutils.jar=`java-pkg_getjar commons-beanutils commons-beanutils.jar`"
	antflags="${antflags} -Dcommons-collections.jar=`java-pkg_getjar commons-collections commons-collections.jar`"
	antflags="${antflags} -Dcommons-logging.jar=`java-pkg_getjar commons-logging commons-logging.jar`"

	ant ${antflags} || die "Compile Failed"
	mkdir ${S}/dist
	jar cfm ${S}/dist/${PN}.jar ${S}/target/conf/MANIFEST.MF -C ${S}/target/classes/ . \
		|| die "Failed to create distributable"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/api/*
}
