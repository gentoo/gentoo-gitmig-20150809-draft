# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-pool/commons-pool-1.2-r2.ebuild,v 1.3 2006/12/09 09:15:56 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Jakarta-Commons component providing general purpose object pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/pool/"
SRC_URI="mirror://apache/jakarta/commons/pool/source/${P}-src.tar.gz"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-collections-2.0"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	${RDEPEND}
	junit? ( >=dev-java/junit-3.7 )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="junit doc"

src_unpack() {
	unpack ${A}
	cd ${S}

	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" > build.properties
	use junit && echo "junit.jar=$(java-pkg_getjars junit)" >> build.properties
}

src_compile() {
	local antflags="build-jar"
	# TODO move unit tests to src_test
	use junit && antflags="${antflags} test"
	use doc && antflags="${antflags} javadoc"

	eant ${antflags} || die "Compilation Failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc README.txt
	dohtml STATUS.html PROPOSAL.html

	use doc && java-pkg_dohtml -r dist/docs/*
}
