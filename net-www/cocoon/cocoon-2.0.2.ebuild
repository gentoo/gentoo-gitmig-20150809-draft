# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-2.0.2.ebuild,v 1.3 2002/08/16 03:01:01 murphy Exp $

A=cocoon-${PV}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Web Publishing Framework for Apache"
SRC_URI="http://xml.apache.org/cocoon/dist/${A}"
HOMEPAGE="http://xml.apache.org/cocoon/"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="Apache-1.1"

# FIXME: tomcat 4.0.x, x != 3 is okay
DEPEND=">=virtual/jdk-1.3
	>=net-www/tomcat-4.0.4
	jikes? ( >=dev-java/jikes-1.15 )
	"

src_unpack() {
	unpack ${A}

	cd ${S}
	echo -e `pwd`
	echo -e 'Patching Cocoon to fix JDBC3 filter bug'
	patch -p0 < ${FILESDIR}/${P}.patch || die

	# FIXME: We should rather depend on packages for JFOR

	# JFOR is required for the optional fo2rtf serializer.
	# Get the JFOR package from http://www.jfor.org/ and place the jar in ${DISTDIR}
	JFOR_JAR="jfor.jar"
	JFOR_HOME="http://www.jfor.org/"
	if [ ! -f ${DISTDIR}/${JFOR_JAR} ]; then
		einfo "Download ${JFOR_JAR} from ${JFOR_HOME} and place it in ${DISTDIR} for optional fo2rtf support"
	else
		cp ${DISTDIR}/${JFOR_JAR} ${S}/lib/optional/
	fi

	# FIXME: We should rather depend on packages for PHP

	# PHP is required for the optional php generator.
	# Get the PHP servlet (phpsrvlt.jar) from http://www.php.net/ and place the jar in ${DISTDIR}
	PHP_JAR="phpsrvlt.jar"
	PHP_HOME="http://www.php.net/"
	if [ ! -f ${DISTDIR}/${PHP_JAR} ]; then
		einfo "Download ${PHP_JAR} from ${PHP_HOME} and place it in ${DISTDIR} for optional PHP support"
	else
		cp ${DISTDIR}/${PHP_JAR} ${S}/lib/optional/
	fi
}

src_compile() {
	local myconf
	use jikes && myconf="-Dbuild.compiler=jikes"

	sh build.sh  \
		${myconf} \
		-Dinclude.webapp.libs=yes \
		-Dinstall.war=$CATALINA_HOME/webapps \
		webapp \
		|| die
}

src_install() {                  
	dodir ${CATALINA_HOME}/webapps
	insinto ${CATALINA_HOME}/webapps
	doins ${S}/build/cocoon/cocoon.war

	dodoc CREDITS INSTALL KEYS README
	dodoc changes.xml announcement.xml todo.xml

	dohtml -r docs/*
}

pkg_postinst() {
	echo -e "\e[32;01m You must restart tomcat to have access to Cocoon. \033[0m"
}
