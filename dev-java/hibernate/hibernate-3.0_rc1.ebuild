# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/hibernate/hibernate-3.0_rc1.ebuild,v 1.2 2005/03/17 01:07:13 st_lim Exp $

inherit java-pkg

DESCRIPTION="Hibernate is a powerful, ultra-high performance object / relational persistence and query service for Java."
MY_PV=${PV/_/}
SRC_URI="mirror://sourceforge/hibernate/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://hibernate.bluemars.net"
LICENSE="LGPL-2"
SLOT="3"
KEYWORDS="~x86 ~amd64"
RDEPEND="
		>=virtual/jre-1.4

		=dev-java/cglib-2*
		dev-java/commons-collections
		dev-java/commons-logging
		=dev-java/dom4j-1*
		dev-java/ehcache
		dev-java/jta
		dev-java/odmg
		dev-java/proxool

		c3p0? (
			dev-java/c3p0
		)
		dbcp? (
			dev-java/commons-pool
			dev-java/commons-dbcp
		)
		oscache? (
			dev-java/oscache
		)
		jboss? (
			>=www-servers/jboss-3.2.5
			dev-java/jmx
		)

		"
DEPEND="${RDEPEND}
		>=virtual/jdk-1.4
		>=dev-java/ant-core-1.5
		junit? (
			dev-java/ant
			dev-java/junit
			dev-db/hsqldb
		)"
IUSE="doc jikes jboss oscache proxool dbcp c3p0 junit"

#S=${WORKDIR}/${PN}-${PV:0:3}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv ${PN}-${PV:0:3} ${S}
	cd ${S}
	rm -rf src/org/hibernate/secure/JACCConfiguration.java

	cd lib

	rm *.jar
	java-pkg_jar-from cglib-2
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-logging
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from ehcache
	java-pkg_jar-from jta
	java-pkg_jar-from odmg

	# c3p0 support
	if use c3p0 ; then
		java-pkg_jar-from c3p0
	else
		find ../src -name "C3P0*" -exec rm {} \;
	fi

	# DBCP support
	if use dbcp ; then
		java-pkg_jar-from commons-dbcp
		java-pkg_jar-from commons-pool
	else
		find ../src -name "DBCP*" -exec rm {} \;
	fi

	# Proxool support
	java-pkg_jar-from proxool

	# OSCache support
	if use oscache ; then
		java-pkg_jar-from oscache
	else
		find ${S}/src -name "OSCache*" -exec rm {} \;
	fi

	# JBoss caching support
	if use jboss ; then
		JBOSSHOME=`java-config -p jboss | sed -e "s/\/client.*$//g"`
		ln -sf ${JBOSSHOME}/server/all/lib/jboss-cache.jar
		ln -sf ${JBOSSHOME}/lib/jboss-system.jar
		java-pkg_jar-from jmx
		if ! [ -r jboss-cache.jar ] ; then
			eerror "The JBoss JARs are not readable.  Most likely, the "
			eerror "/var/lib/jboss directory is not traverseable  by the "
			eerror "portage user."
			die "See above message."
		fi
	else
		find ${S}/src -name "Tree*" -exec rm {} \;
	fi

	if use junit ; then
		java-pkg_jar-from junit
		java-pkg_jar-from hsqldb
	fi

	cd ..

	# JCS is deprecated, so don't compile it
	find src -name "JCS*" -exec rm {} \;

	sed -r -i \
		-e '/<splash/d' \
		-e 's/..\/\$\{name\}/dist/g' \
			build.xml
	sed -r -i \
		-e "s/JCSCache/EhCache/g" \
			test/org/hibernate/test/CacheTest.java
}

src_compile() {
	use jikes && ! use jboss && export ANT_OPTS="-Dbuild.compiler=jikes"
	targets="jar"
	if use junit ; then
		targets="${targets} junitreport"
	fi
	use doc && targets="${targets} javadoc"
	ant -q ${targets} || die "Build failed."
}

src_install() {
	java-pkg_dojar dist/hibernate3.jar
	dodoc *.txt
	use doc && java-pkg_dohtml -r dist/doc/*
	insinto /usr/share/doc/${P}/sample
	doins etc/*.xml etc/*.properties src/META-INF/ra.xml
}
