# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/datavision-bin/datavision-bin-0.8.1.ebuild,v 1.1 2004/07/30 19:31:35 axxo Exp $

DESCRIPTION="DataVision is an Open Source reporting tool similar to Crystal Reports"
SRC_URI="mirror:///sourceforge/datavision/${P/-bin}.tar.gz"
HOMEPAGE="http://datavision.sourceforge.net/"

IUSE="mysql postgres"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="x86 amd64 ~ppc"

DATAVISION_HOME=/opt/datavision

RDEPEND=">=virtual/jdk-1.3 \
	mysql? ( >=jdbc-mysql-3.0 ) \
	postgres? ( >=jdbc2-postgresql-7.3 )"


src_compile() { :; }

src_install() {
	dodir ${DATAVISION_HOME}
	cp -r * ${D}${DATAVISION_HOME}
}

pkg_postinst() {
	einfo "CONFIGURATION NOTES"
	echo " "
	einfo "Make sure your CLASSPATH variable is updated via java-config(1)"
	einfo "to use your desired JDBC driver."
	echo " "
	einfo "You must then create a database. Run ${DATAVISION_HOME}/datavision.sh"
	einfo "and fill the connection dialog box with your database details."

	if use mysql; then
	echo " "
	echo "MySQL example:"
	eerror "Driver class name: com.mysql.jdbc.Drive"
	eerror "Connection: jdbc:mysql://localhost/database"
	fi

	if use postgres; then
	echo " "
	echo "PostgreSQL example:"
	eerror "Driver class name:org.postgresql.Driver"
	eerror "Connection: jdbc:postgresql://localhost/database"
	fi
	echo " "
	echo " "
}
