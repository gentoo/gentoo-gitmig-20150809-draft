# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0-r4.ebuild,v 1.4 2004/10/16 17:04:14 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="The CLI library provides a simple and easy to use API for working with the command line arguments and options."
HOMEPAGE="http://jakarta.apache.org/commons/cli/"
SRC_URI="mirror://apache/jakarta/commons/cli/source/cli-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-logging-1.0
	>=dev-java/junit-3.7
	>=dev-java/commons-lang-1.0"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc jikes junit"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-gentoo.diff || die "patch failed"
	echo "commons-logging.jar=`java-config -p commons-logging`" >> build.properties
	echo "commons-lang.jar=`java-config -p commons-lang`" >> build.properties
	use junit && echo "junit.jar=`java-config -p junit`" >> build.properties
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	mv ${S}/target/${P}.jar ${S}/target/${PN}.jar
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dohtml -r target/docs/
	dodoc README.txt
}

