# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-digester/commons-digester-1.5.ebuild,v 1.2 2004/03/23 02:49:24 zx Exp $

inherit jakarta-commons

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta Digester component reads XML configuration files to provide initialization of various Java objects within the system."
HOMEPAGE="http://jakarta.apache.org/commons/digester.html"
SRC_URI="mirror://apache/jakarta/commons/digester/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-beanutils-1.5
	>=dev-java/commons-collections-2.1
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/commons-beanutils-1.5
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes junit"

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	use junit && antflags="${antflags} -Djunit.jar=`java-config --classpath=junit`"
	antflags="${antflags} -Dcommons-beanutils.jar=`java-config --classpath=commons-beanutils`"
	antflags="${antflags} -Dcommons-collections.jar=`java-config --classpath=commons-collections`"
	antflags="${antflags} -Dcommons-logging.jar=/usr/share/commons-logging/lib/commons-logging.jar"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && dohtml -r dist/docs/api/*
}
