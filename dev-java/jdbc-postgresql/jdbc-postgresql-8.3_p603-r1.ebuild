# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-postgresql/jdbc-postgresql-8.3_p603-r1.ebuild,v 1.3 2008/05/12 11:04:18 nixnut Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

MY_PN="postgresql-jdbc"
MY_PV="${PV/_p/-}"
MY_P="${MY_PN}-${MY_PV}.src"

DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://jdbc.postgresql.org/"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 x86"
IUSE="java5 java6 test"

DEPEND=">=dev-java/java-config-2.0.31
	java6? ( =virtual/jdk-1.6* )
	java5? ( =virtual/jdk-1.5* )
	!java5? ( !java6? ( =virtual/jdk-1.4* ) )
	doc? (
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	!test? ( >=dev-java/ant-core-1.6 )
	test? (
		=dev-java/junit-3.8*
		>=dev-java/ant-1.6
		dev-java/ant-junit
		dev-db/postgresql
	)"
RDEPEND="java6? ( >=virtual/jre-1.6 )
	java5? ( >=virtual/jre-1.5 )
	!java5? ( !java6? ( >=virtual/jre-1.4 ) )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use java5 && use java6 ; then
		eerror "You cannot use both 'java5' and 'java6' USE flags at the same time"
		exit 1
	fi

	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	java-ant_rewrite-classpath
}

src_compile() {
	eant jar $(use_doc publicapi)

	# There is a task that creates this doc but I didn't find a way how to use system catalog
	# to lookup the stylesheet so the 'doc' target is rewritten here to use system call instead.
	if use doc; then
		mkdir -p "${S}/build/doc"
		xsltproc -o "${S}/build/doc/pgjdbc.html" http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl \
			"${S}/doc/pgjdbc.xml"
	fi
}

src_test() {
	einfo "In order to run the tests successfully, you have to have:"
	einfo "1) PostgreSQL server running"
	einfo "2) database 'test' defined with user 'test' with password 'password'"
	einfo "   as owner of the database"
	einfo "3) plpgsql support in the 'test' database"
	einfo
	einfo "You can find a general info on how to perform these steps at"
	einfo "http://gentoo-wiki.com/HOWTO_Configure_Postgresql"

	ANT_TASKS="ant-junit" eant test -Dgentoo.classpath=$(java-pkg_getjars --build-only junit)
}

src_install() {
	java-pkg_newjar jars/postgresql.jar jdbc-postgresql.jar

	if use doc ; then
		java-pkg_dojavadoc build/publicapi
		dohtml build/doc/pgjdbc.html
	fi

	use source && java-pkg_dosrc org
}
