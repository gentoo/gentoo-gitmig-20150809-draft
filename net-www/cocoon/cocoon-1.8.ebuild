# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-1.8.ebuild,v 1.3 2001/01/27 14:41:33 achim Exp $

A=Cocoon-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Web Publishing Framework for Apache"
SRC_URI="http://xml.apache.org/cocoon/dist/"${A}
HOMEPAGE="http://xml.apache.org/cocoon/"

DEPEND=">=dev-lang/jdk-1.2.2
	>=dev-java/fesi-1
	>=dev-java/xt-1
	>=dev-java/jndi-1.2.1"

src_unpack() {
  unpack ${A}
}

src_compile() {
  CLASSPATH=/opt/java/src.jar:/opt/java/lib/tools.jar
  CLASSPATH=${CLASSPATH}:/usr/lib/java/jndi.jar
  CLASSPATH=${CLASSPATH}:/usr/lib/java/xt.jar:/usr/lib/java/sax.jar
  CLASSPATH=${CLASSPATH}:/usr/lib/java/fesi.jar
  export CLASSPATH
  export JAVA_HOME=/opt/java
  cd ${S}
  sh build.sh
}

src_install() {                               
  cd ${S}
  insinto /opt/tomcat/lib/cocoon
  for i in xerces_1_2 xalan_1_2_D02 fop_0_13_0 \
	   servlet_2_2 turbine-pool
  do
     doins  lib/$i.jar
  done
  doins build/cocoon.jar
  dodir /opt/tomcat/webapps/cocoon/repository
  insinto /opt/tomcat/webapps/cocoon/WEB-INF
  cp -a samples ${D}/opt/tomcat/webapps/cocoon
  doins ${FILESDIR}/cocoon.properties
  doins ${FILESDIR}/web.xml
  dodoc README LICENSE
  dodir /usr/doc/${PF}/html
  cp -a docs/* ${D}/usr/doc/${PF}/html
  find ${D}/usr/doc/${PF}/html -type f -exec gzip -9 {} \;
}


