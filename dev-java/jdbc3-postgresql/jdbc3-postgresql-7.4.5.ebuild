# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc3-postgresql/jdbc3-postgresql-7.4.5.ebuild,v 1.6 2006/10/05 17:33:14 gustavoz Exp $

inherit java-pkg eutils versionator

DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-opt-${PV}.tar.bz2"
HOMEPAGE="http://jdbc.postgresql.org/"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
LICENSE="POSTGRESQL"
SLOT="0"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	dev-java/java-config"

RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/postgresql-${PV}/src/interfaces/jdbc

src_unpack() {
	unpack ${A}
	cd ${S}

	# prepare build.properties
	echo "major=$(get_major_version)" > build.properties
	echo "minor=$(get_version_component_range 2)" >> build.properties
	echo "fullversion=${PV}" >> build.properties
	echo def_pgport=5432 >> build.properties
	echo enable_debug=no >> build.properties
}


src_compile() {
	local antflags="jar"
	ant ${antflags} || die "build failed!"
}

src_install() {
	java-pkg_newjar jars/postgresql.jar ${PN}.jar
}
