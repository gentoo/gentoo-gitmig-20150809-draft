# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-3.2.1.ebuild,v 1.3 2002/01/23 20:06:16 karltk Exp $

A="jakarta-tomcat-3.2.1-src.tar.gz jakarta-servletapi-3.2-src.tar.gz jakarta-ant-1.3-src.tar.gz"
S=${WORKDIR}
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/jakarta-tomcat/release/v3.2.1/src/jakarta-tomcat-3.2.1-src.tar.gz
	 http://jakarta.apache.org/builds/jakarta-tomcat/release/v3.2.1/src/jakarta-servletapi-3.2-src.tar.gz
	 http://jakarta.apache.org/builds/jakarta-ant/release/v1.3/src/jakarta-ant-1.3-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=dev-lang/jdk-1.2
	>=net-www/apache-1.3"

src_unpack() {
	unpack ${A}
	mv jakarta-ant-1.3 jakarta-ant
	mv jakarta-servletapi-3.2-src jakarta-servletapi
	mv jakarta-tomcat-3.2.1-src jakarta-tomcat
}

src_compile() {

	export CLASSPATH=`java-config --full-classpath=jaxp,ant,jsse`

	echo "Building ant..."
	cd ${S}/jakarta-ant
	./bootstrap.sh
	mv bootstrap/bin .
	echo "Building servletapi..."
	cd ${S}/jakarta-servletapi
	sh ./build.sh dist
	echo "Building tomcat..."
	cd ${S}/jakarta-tomcat
	sh ./build.sh dist
	cd src/native/apache1.3
	make -f Makefile.linux

}

src_install() {
	
	dodir /usr/share/tomcat
	cp -a ${S}/build/tomcat/* ${D}/usr/share/tomcat
	dodir /usr/share/tomcat/lib
	insinto /usr/share/tomcat/lib
	doins ${S}/build/tomcat/classes/tomcat.jar
	doins ${S}/build/tomcat/lib/xml.jar
	rm -rf ${D}/opt/tomcat/classes
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
	dohtml etc/*.html
	dohtml *.html
	dohtml -r src/doc/*.html
}

pkg_config() {

   einfo "Activating Servlet Engine..."
   ${ROOT}/usr/sbin/rc-update add jakarta
}



