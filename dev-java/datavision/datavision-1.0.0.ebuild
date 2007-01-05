# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/datavision/datavision-1.0.0.ebuild,v 1.2 2007/01/05 20:43:24 caster Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Open Source reporting tool similar to Crystal Reports"
SRC_URI="mirror://sourceforge/datavision/${P}.tar.gz"
HOMEPAGE="http://datavision.sourceforge.net/"
IUSE="doc junit mysql postgres"
SLOT="1.0"
LICENSE="Apache-1.1"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/itext-1.02b
	>=dev-java/jruby-0.7.0
	=dev-java/gnu-regexp-1.1*
	=dev-java/jcalendar-1.2*
	=dev-java/minml2-0.3*
	=dev-java/bsf-2.3*
	dev-lang/ruby
	mysql? ( >=dev-java/jdbc-mysql-3.0 )
	postgres? ( >=dev-java/jdbc2-postgresql-7.3 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	junit? ( >=dev-java/junit-3.7 )"

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	# lets avoid a new packed jar issue :)
	rm -f *.jar

	java-pkg_jar-from minml2-0.3 minml2.jar
	java-pkg_jar-from gnu-regexp-1
	java-pkg_jar-from itext
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jcalendar-1.2
	java-pkg_jar-from jruby

	# the new build.xml
	cd ${S}
#	rm build.xml
#	cp ${FILESDIR}/build.xml .

	# patch startup file
	epatch ${FILESDIR}/datavision-sh.patch

	if use mysql; then
		echo "localclasspath=\${localclasspath}:\`java-config -p jdbc-mysql\`" >> datavision.sh
	fi
	if use postgres; then
		echo "localclasspath=\${localclasspath}:\`java-config -p jdbc2-postgresql-6\`" >> datavision.sh
	fi

	echo "\$JAVA -cp \${localclasspath} jimm.datavision.DataVision \$*" >> datavision.sh
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs.release"
	eant ${antflags}
}

src_install() {
	java-pkg_dojar lib/DataVision.jar

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
