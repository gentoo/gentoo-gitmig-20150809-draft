# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.7.0.ebuild,v 1.1 2004/08/03 10:53:26 axxo Exp $

inherit java-pkg

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta BeanUtils component provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://jakarta.apache.org/commons/beanutils.html"
SRC_URI="mirror://apache/jakarta/commons/beanutils/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc jikes junit"

src_compile() {
	local antflags="jar"
	cd ${S}
	cp LICENSE.txt LICENSE

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	if use junit ; then
		echo "junit.jar=`java-config --classpath=junit`" | sed  s/:.*// >> build.properties
		antflags="${antflags} test"
	fi

	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "failed to compile"
}

src_install () {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc RELEASE-NOTES.txt LICENSE
	dohtml STATUS.html PROPOSAL.html

	use doc && dohtml -r dist/docs/*
}
