# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-1.7.4.ebuild,v 1.4 2000/11/02 08:31:53 achim Exp $

P=cocoon-1.7.4
A=Cocoon-1.7.4.tar.gz
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
  insinto /usr/lib/java
  for i in xerces_1_0_3 xalan_1_0_1 fop_0_12_1 \
	   servlet_2_2 stylebook-1.0-b2
  do
     doins  lib/$i.jar
  done
  doins build/cocoon.jar
  insinto /opt/tomcat/webapps/ROOT
  doins ${O}/files/cocoon.properties
  dodoc README LICENSE
  dodir /usr/doc/${PF}/html
  cp -a docs/* ${D}/usr/doc/${PF}/html
  find ${D}/usr/doc/${PF}/html -type f -exec gzip -9 {} \;
}




