# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/jakarta/jakarta-3.1-r2.ebuild,v 1.7 2002/04/27 21:28:50 seemant Exp $

S=${WORKDIR}
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/tomcat/release/v3.1/src/jakarta-tomcat.tar.gz
	 http://jakarta.apache.org/builds/tomcat/release/v3.1/src/jakarta-ant.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

DEPEND="virtual/glibc sys-apps/which sys-devel/perl
	>=virtual/jdk-1.2
	>=net-www/apache-1.3"
RDEPEND="virtual/glibc
	>=virtual/jdk-1.2
	>=net-www/apache-1.3"

src_unpack() {
	unpack ${A}
}

src_compile() {      
	echo "Building ant..."
	cd ${S}/jakarta-ant
	./bootstrap.sh
	echo "Building tomcat..."
	cd ${S}/jakarta-tomcat
	./build.sh
	cd src/native/apache/jserv
	apxs -c mod_jserv.c jserv*.c
	cd ${S}/build/tomcat/classes
	jar -cf tomcat.jar javax org
	rm -rf javax
	rm -rf org
}

src_install() {
	dodir /usr/share/tomcat
	cp -a ${S}/build/tomcat/* ${D}/usr/share/tomcat
	insinto /usr/share/tomcat/lib
	doins ${S}/build/tomcat/classes/tomcat.jar
	doins ${S}/build/tomcat/lib/xml.jar
	rm -rf ${D}/usr/share/tomcat/classes
	insinto /usr/lib/apache
	doins ${S}/jakarta-tomcat/src/native/apache/jserv/mod_jserv.so
	insinto /etc/httpd
	doins ${FILESDIR}/httpd.tomcat
	insinto /etc/rc.d/init.d
	insopts -m755
	doins ${FILESDIR}/jakarta
	#insinto /opt/tomcat/conf
	#doins ${O}/files/web.xml

	cd ${S}/jakarta-tomcat
	dodoc BUGS LICENSE README RELEASE-* TODO etc/*.txt src/doc/faq src/doc/readme

	dohtml -r etc/*

}

pkg_config() {

	einfo "Activating Servlet Engine..."
	${ROOT}/usr/sbin/rc-update add jakarta
}



