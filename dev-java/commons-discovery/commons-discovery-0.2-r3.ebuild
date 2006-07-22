# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-discovery/commons-discovery-0.2-r3.ebuild,v 1.1 2006/07/22 22:41:34 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Commons Discovery: Service Discovery component"
HOMEPAGE="http://jakarta.apache.org/commons/discovery"
SRC_URI="mirror://apache/jakarta/commons/discovery/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="source junit doc"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-logging"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	source? ( app-arch/zip )
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
	use junit && antflags="${antflags} test.discovery"
	eant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	if use doc; then
		java-pkg_dohtml PROPOSAL.html STATUS.html usersguide.html
		java-pkg_dohtml -r ${S}/dist/docs/api
	fi

	use source && java-pkg_dosrc ${S}/src/java/*
}
