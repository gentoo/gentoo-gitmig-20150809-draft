# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/mysql-jdbc/mysql-jdbc-1.2.3-r1.ebuild,v 1.3 2000/11/02 08:31:50 achim Exp $

P=mysql-jdbc-1.2c
A=mm.mysql.jdbc-1.2c.tar.gz
S=${WORKDIR}/mm.mysql.jdbc-1.2c
DESCRIPTION="JDBC Driver for MySQL"
SRC_URI="http://www.mysql.com/Downloads/Contrib/"${A}
HOMEPAGE="http://www.mysql.com/"

DEPEND=">=dev-lang/jdk-1.2.2"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  jar -cf mysql-jdbc.jar org
}

src_install() {                               
  cd ${S}
  insinto /usr/lib/java
  doins  mysql-jdbc.jar
  cd doc
  docinto html
  dodoc *.html *.gif
  docinto html/mm.doc
  dodoc mm.doc/*.html mm.doc/*.css
  docinto html/mm.doc/stylesheet-images
  dodoc mm.doc/stylesheet-images/*.gif
  docinto html/apidoc
  dodoc apidoc/*.html apidoc/*.css
  docinto html/apidoc/org/gjt/mm/mysql
  dodoc apidoc/org/gjt/mm/mysql/*.html
}



