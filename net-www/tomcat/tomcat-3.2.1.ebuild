# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-3.2.1.ebuild,v 1.1 2001/07/10 00:08:12 achim Exp $

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
	>=net-www/apache-ssl-1.3"

src_unpack() {
  unpack ${A}
  mv jakarta-ant-1.3 jakarta-ant
  mv jakarta-servletapi-3.2-src jakarta-servletapi
  mv jakarta-tomcat-3.2.1-src jakarta-tomcat
}

src_compile() {

  CLASSPATH=/opt/java/src.jar:/opt/java/lib/tools.jar
  CLASSPATH=$CLASSPATH:${S}/jakarta-ant/lib/jaxp.jar:${S}/jakarta-ant/lib/parser.jar
  CLASSPATH=$CLASSPATH:${S}/jakarta-ant/build/lib/ant.jar:${S}/jakarta-ant/build/lib/optional.jar
  CLASSPATH=$CLASSPATH:/usr/lib/java/jsse.jar:/usr/lib/java/jnet.jar:/usr/lib/java/jcert.jar

  export CLASSPATH
  export JAVA_HOME=/opt/java

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



