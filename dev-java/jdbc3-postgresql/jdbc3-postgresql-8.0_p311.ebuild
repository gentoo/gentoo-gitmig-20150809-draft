# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc3-postgresql/jdbc3-postgresql-8.0_p311.ebuild,v 1.1 2005/04/12 20:03:03 luckyduck Exp $

inherit java-pkg

DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/postgresql-jdbc-${PV/_p/-}.src.tar.gz"
HOMEPAGE="http://jdbc.postgresql.org/"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc examples jikes source"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.6
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/postgresql-jdbc-${PV/_p/-}.src

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} publicapi"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "build failed!"
}

src_install() {
	mv jars/postgresql.jar jars/${PN}.jar
	java-pkg_dojar jars/${PN}.jar

	use doc && java-pkg_dohtml -r ${S}/build/publicapi/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/example/* ${D}/usr/share/doc/${PF}/examples
		java-pkg_dojar jars/postgresql-examples.jar
	fi
	use source && java-pkg_dosrc ${S}/org
}
