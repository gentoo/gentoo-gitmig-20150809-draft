# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0-r4.ebuild,v 1.8 2005/02/06 17:18:01 corsair Exp $

inherit java-pkg eutils

DESCRIPTION="The CLI library provides a simple and easy to use API for working with the command line arguments and options."
HOMEPAGE="http://jakarta.apache.org/commons/cli/"
SRC_URI="mirror://apache/jakarta/commons/cli/source/cli-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	junit? ( >=dev-java/junit-3.7 )
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-1.6.2"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-logging-1.0
	>=dev-java/commons-lang-1.0"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 sparc ppc amd64 ppc64"
IUSE="doc jikes junit"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-${PV}-gentoo.diff || die "patch failed"
	echo "commons-logging.jar=`java-config -p commons-logging`" >> build.properties
	echo "commons-lang.jar=`java-config -p commons-lang`" >> build.properties
	if use junit; then
		echo "junit.jar=`java-config -p junit`" >> build.properties
	fi
}

src_compile() {
	local antflags="jar"
	if use doc; then
		antflags="${antflags} javadoc"
	fi
	if use junit; then
		antflags="${antflags} test"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "compilation failed"
}

src_install() {
	mv ${S}/target/${P}.jar ${S}/target/${PN}.jar
	java-pkg_dojar target/${PN}.jar

	dodoc README.txt
	if use doc; then
		java-pkg_dohtml -r target/docs/
	fi
}

