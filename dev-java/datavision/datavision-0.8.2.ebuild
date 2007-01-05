# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/datavision/datavision-0.8.2.ebuild,v 1.12 2007/01/05 20:43:24 caster Exp $

inherit java-pkg

DESCRIPTION="Open Source reporting tool similar to Crystal Reports"
SRC_URI="mirror://sourceforge/datavision/${P}.tar.gz"
HOMEPAGE="http://datavision.sourceforge.net/"
IUSE="doc jikes junit mysql postgres"
SLOT="0.8"
LICENSE="Apache-1.1"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/itext-1.02b
	>=dev-java/jruby-0.7.0
	=dev-java/gnu-regexp-1.1*
	=dev-java/jcalendar-1.2*
	=dev-java/minml2-0.3*
	mysql? ( >=dev-java/jdbc-mysql-3.0 )
	postgres? ( >=dev-java/jdbc2-postgresql-7.3 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	junit? ( >=dev-java/junit-3.7 )
	jikes? ( >=dev-java/jikes-1.21 )"

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	# lets avoid a new packed jar issue :)
	rm -f *.jar

	java-pkg_jar-from minml2-0.3 minml2.jar
	java-pkg_jar-from gnu-regexp-1
	java-pkg_jar-from itext
	java-pkg_jar-from jcalendar-1.2
	java-pkg_jar-from jruby

	# the new build.xml
	cd ${S}
	rm build.xml
	cp ${FILESDIR}/build.xml .

	# copy the 'new' startup file to ${S}
	rm datavision.sh
	cp ${FILESDIR}/datavision.sh .

	if use mysql; then
		echo "localclasspath=\${localclasspath}:\`java-config -p jdbc-mysql\`" >> datavision.sh
	fi
	if use postgres; then
		echo "localclasspath=\${localclasspath}:\`java-config -p jdbc2-postgres\`" >> datavision.sh
	fi

	echo "\$JAVA -cp \${localclasspath} jimm.datavision.DataVision $*" >> datavision.sh
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed too build"
}

src_install() {
	java-pkg_dojar dist/DataVision.jar

	newbin datavision.sh datavision

	dodoc ChangeLog Credits README TODO
	if use doc; then
		java-pkg_dohtml docs/DataVision/*
	fi
}

pkg_postinst() {
	elog "CONFIGURATION NOTES"
	elog
	elog "Make sure your CLASSPATH variable is updated via java-config(1)"
	elog "to use your desired JDBC driver."
	elog
	elog "You must then create a database. Run '/usr/bin/${PN}'"
	elog "and fill the connection dialog box with your database details."

	if use mysql; then
		elog
		elog "MySQL example:"
		elog "Driver class name: com.mysql.jdbc.Driver"
		elog "Connection: jdbc:mysql://localhost/database"
	fi

	if use postgres; then
		elog
		elog "PostgreSQL example:"
		elog "Driver class name:org.postgresql.Driver"
		elog "Connection: jdbc:postgresql://localhost/database"
	fi
	elog
}
