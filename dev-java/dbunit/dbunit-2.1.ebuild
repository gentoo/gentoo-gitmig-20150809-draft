# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dbunit/dbunit-2.1.ebuild,v 1.4 2005/07/09 23:45:18 agriffis Exp $

inherit java-pkg

DESCRIPTION="DBUnit is a JUnit extension targeted for database-driven projects that, puts your database into a known state between test runs."
HOMEPAGE="http://www.dbunit.org"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/crimson-1*
	>=dev-db/hsqldb-1.7.2.4
	=dev-java/mockmaker-1.12.0*
	>=dev-java/mockobjects-0.09
	>=dev-java/poi-2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/build.xml build.xml

	mkdir lib && cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from crimson-1
	java-pkg_jar-from hsqldb
	java-pkg_jar-from mockmaker-1.12
	java-pkg_jar-from mockobjects
	java-pkg_jar-from poi
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r docs/*
}
