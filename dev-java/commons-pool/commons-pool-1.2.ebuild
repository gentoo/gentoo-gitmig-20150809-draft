# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-pool/commons-pool-1.2.ebuild,v 1.3 2004/11/30 21:32:46 swegener Exp $

inherit java-pkg

DESCRIPTION="Jakarta-Commons component providing general purpose object pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/pool.html"
SRC_URI="mirror://apache/jakarta/commons/pool/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.0
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-collections-2.0"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="jikes junit doc"

S=${WORKDIR}/${PN}-${PV}
src_unpack() {
	unpack ${A}
	cd ${S}

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	use junit && echo "junit.jar=`java-config --classpath=junit`" >> build.properties
}

src_compile() {
	local antflags

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} dist || die "Compilation Failed"

	if use junit; then
		ant ${antflags} test || die "Testing Classes Failed"
	fi

	if use doc; then
		ant javadoc || die "Unable to create documents"
	fi
}

src_install () {
	java-pkg_dojar dist/${PN}.jar
	dodoc README.txt
	dohtml STATUS.html PROPOSAL.html

	use doc && 	java-pkg_dohtml -r dist/docs/*
}
