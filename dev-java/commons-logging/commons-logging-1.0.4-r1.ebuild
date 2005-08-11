# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-logging/commons-logging-1.0.4-r1.ebuild,v 1.9 2005/08/11 17:09:15 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="The Jakarta-Commons Logging package is an ultra-thin bridge between different logging libraries."
HOMEPAGE="http://jakarta.apache.org/commons/logging/"
SRC_URI="mirror://apache/jakarta/commons/logging/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ppc64 sparc ppc"
IUSE="avalon doc jikes source"

RDEPEND=">=virtual/jre-1.3
	=dev-java/avalon-logkit-1.2*
	dev-java/log4j
	avalon? ( =dev-java/avalon-framework-4.2* )"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )
	${RDEPEND}"

S="${WORKDIR}/${P}-src/"

src_unpack() {
	unpack ${A}
	cd ${S}

	echo "log4j.jar=$(java-pkg_getjars log4j)" > build.properties
	echo "logkit.jar=$(java-pkg_getjars avalon-logkit-1.2)" >> build.properties
	use avalon && echo "avalon-framework.jar=$(java-pkg_getjars avalon-framework-4.2)" >> build.properties
}

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar target/${PN}-api.jar target/${PN}.jar

	dodoc RELEASE-NOTES.txt
	dohtml PROPOSAL.html STATUS.html usersguide.html
	use doc && java-pkg_dohtml -r dist/docs/
	use source && java-pkg_dosrc src/java/org
}
