# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/jakarta/jakarta-3.1-r2.ebuild,v 1.3 2001/06/04 00:16:12 achim Exp $

P=jakarta-3.1
A="jakarta-tomcat.tar.gz jakarta-ant.tar.gz"
S=${WORKDIR}
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/tomcat/release/v3.1/src/jakarta-tomcat.tar.gz
	 http://jakarta.apache.org/builds/tomcat/release/v3.1/src/jakarta-ant.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

DEPEND="virtual/glibc sys-apps/which sys-devel/perl
	>=dev-lang/jdk-1.2
	>=net-www/apache-ssl-1.3"
RDEPEND="virtual/glibc
	>=dev-lang/jdk-1.2
	>=net-www/apache-ssl-1.3"

src_unpack() {
  unpack ${A}
}

src_compile() {      
  export CLASSPATH=/opt/java/src.jar:/opt/java/lib/tools.jar                     

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
  dodir /opt
  cp -a ${S}/build/tomcat ${D}/opt
  insinto /opt/tomcat/lib
  doins ${S}/build/tomcat/classes/tomcat.jar
  doins ${S}/build/tomcat/lib/xml.jar
  rm -rf ${D}/opt/tomcat/classes
  insinto /usr/lib/apache
  doins ${S}/jakarta-tomcat/src/native/apache/jserv/mod_jserv.so
  insinto /etc/httpd
  doins ${O}/files/httpd.tomcat
  insinto /etc/rc.d/init.d
  insopts -m755
  doins ${O}/files/jakarta
  #insinto /opt/tomcat/conf
  #doins ${O}/files/web.xml

  cd ${S}/jakarta-tomcat
  dodoc BUGS LICENSE README RELEASE-* TODO etc/*.txt src/doc/faq src/doc/readme
  docinto html
  dodoc *.html etc/*.html
  docinto html/guide
  dodoc src/doc/uguide/*.html
  dodoc src/doc/uguide/*.css
  docinto html/guide/images
  dodoc src/doc/uguide/images/*.gif
  dodir /usr/local/httpd/logs


}

pkg_config() {

   einfo "Activating Servlet Engine..."
   ${ROOT}/usr/sbin/rc-update add jakarta
}



