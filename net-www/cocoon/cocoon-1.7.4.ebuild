# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-1.7.4.ebuild,v 1.1 2000/08/25 15:10:24 achim Exp $

P=cocoon-1.7.4
A=Cocoon-1.7.4.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Web Publishing Framework for Apache"
SRC_URI="http://xml.apache.org/cocoon/dist/"${A}
HOMEPAGE="http://xml.apache.org/cocoon/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  CLASSPATH=/opt/java/src.jar:/opt/java/lib/tools.jar
  CLASSPATH=${CLASSPATH}:/opt/java/lib/jndi.jar
  CLASSPATH=${CLASSPATH}:/opt/java/lib/xt.jar:/opt/java/lib/sax.jar
  CLASSPATH=${CLASSPATH}:/opt/java/lib/fesi.jar
  export CLASSPATH
  export JAVA_HOME=/opt/java
  cd ${S}
  sh build.sh
  cd build/src
  jar cf ../classes/cocoon.jar org WEB-INF
}

src_install() {                               
  cd ${S}
  insinto /opt/java/lib
  for i in xerces_1_0_1 xalan_0_19_4 fop_0_12_1
  do
     doins  lib/$i.jar
  done
  doins build/classes/cocoon.jar
  insinto /opt/jakarta/tomcat/conf
  doins ${O}/files/cocoon.properties
  dodoc README LICENSE
  dodir /usr/doc/${PF}/html
  cp -a docs/* ${D}/usr/doc/${PF}/html
  find ${D}/usr/doc/${PF}/html -type f -exec gzip -9 {} \;
}




