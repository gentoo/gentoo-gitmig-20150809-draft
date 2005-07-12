# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-discovery/commons-discovery-0.2-r2.ebuild,v 1.3 2005/07/12 11:53:53 axxo Exp $

inherit java-pkg eutils
DESCRIPTION="Commons Discovery: Service Discovery component"
HOMEPAGE="http://jakarta.apache.org/commons/discovery"
SRC_URI="mirror://apache/jakarta/commons/discovery/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE="source junit jikes doc"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-logging"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant
	source? ( app-arch/zip )
	jikes? ( >=dev-java/jikes-1.21 )
	junit? ( >=dev-java/junit-3.8 )"

S="${WORKDIR}/${P}-src/discovery"

src_unpack() {
	unpack ${A}
	cd ${S}

	chmod u+w ${S}/../discovery
	epatch ${FILESDIR}/${P}-gentoo.diff

	mkdir -p ${S}/target/lib && cd ${S}/target/lib
	use junit && java-pkg_jar-from junit junit.jar
	java-pkg_jar-from commons-logging
}

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test.discovery"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	if use doc; then
		dodoc RELEASE-NOTES.txt
		java-pkg_dohtml PROPOSAL.html STATUS.html usersguide.html
		java-pkg_dohtml -r ${S}/dist/docs/api
	fi
	use source && java-pkg_dosrc ${S}/src/java/*
}
