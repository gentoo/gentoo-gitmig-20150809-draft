# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hsqldb/hsqldb-1.7.2.4.ebuild,v 1.1 2004/10/30 20:58:31 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="HSQLDB is the leading SQL relational database engine written in Java."
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV//./_}.zip"
HOMEPAGE="http://hsqldb.sourceforge.net"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
		=dev-java/servletapi-2.4*"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
		rm *.jar
		java-pkg_jar-from servletapi-2.3 servletapi-2.3.jar servlet.jar
	cd ..
	sed -i -r \
		-e "s/etc\/sysconfig/etc\/conf.d/g" \
			bin/hsqldb
	einfo "Cleaning build directory..."
	ant -q -f build/build.xml cleanall || die "failed too clean"

	einfo "Preparing configuration files..."
	mkdir conf
	JAVA_CMD=$(java-config -J)
	HSQLDB_JAR=/usr/share/hsqldb/lib/hsqldb.jar
	sed -e "s/^JAVA_EXECUTABLE=.*$/JAVA_EXECUTABLE=${JAVA_CMD//\//\\/}/g" \
		-e "s/^HSQLDB_JAR_PATH=.*$/HSQLDB_JAR_PATH=${HSQLDB_JAR//\//\\/}/g" \
		-e "s/^SERVER_HOME=.*$/SERVER_HOME=\/var\/lib\/hsqldb/g" \
		-e "s/^HSQLDB_OWNER=.*$/HSQLDB_OWNER=hsqldb/g" \
		-e 's/^#AUTH_FILE=.*$/AUTH_FILE=${SERVER_HOME}\/sqltool.rc/g' \
		src/org/hsqldb/sample/sample-hsqldb.cfg > conf/hsqldb
	cp ${FILESDIR}/server.properties conf
	cp ${FILESDIR}/sqltool.rc conf
}

src_compile() {
	local antflags="-f build/build.xml"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	antflags="${antflags} jar jarclient jarsqltool"
	use doc && antflags="${antflags} javadocdev"
	einfo "Starting compilation..."
	ant -q ${antflags} || die "Compilation failed."
}

src_install() {
	dojar lib/hsql*.jar
	dodoc doc/*.txt
	use doc && dohtml -r doc/src

	doinitd ${FILESDIR}/hsqldb
	doconfd conf/hsqldb
	insinto /etc/hsqldb
	insopts -m 0600
	doins conf/server.properties
	doins conf/sqltool.rc


	dodir /var/lib/hsqldb/bin
	keepdir /var/lib/hsqldb
	exeinto /var/lib/hsqldb/bin
	doexe bin/hsqldb
	dosym /etc/hsqldb/server.properties /var/lib/hsqldb/server.properties
	dosym /etc/hsqldb/sqltool.rc /var/lib/hsqldb/sqltool.rc
}

pkg_postinst() {
	if ! enewgroup hsqldb || ! enewuser hsqldb -1 /bin/sh /dev/hull hsqldb; then
		die "Unable to add hsqldb user and hsqldb group."
	fi

	chown -R hsqldb:hsqldb /var/lib/hsqldb
	chmod o-rwx /var/lib/hsqldb
}

