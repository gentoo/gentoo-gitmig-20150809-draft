# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/mysql-jdbc/mysql-jdbc-1.2.3-r1.ebuild,v 1.4 2002/01/23 20:06:16 karltk Exp $

P=mysql-jdbc-1.2c
A=mm.mysql.jdbc-1.2c.tar.gz
S=${WORKDIR}/mm.mysql.jdbc-1.2c
DESCRIPTION="JDBC Driver for MySQL"
SRC_URI="http://www.mysql.com/Downloads/Contrib/"${A}
HOMEPAGE="http://www.mysql.com/"

DEPEND=">=virtual/jdk-1.2.2"

src_unpack() {
	unpack ${A}
}

src_compile() {                           
	jar -cf mysql-jdbc.jar org
}

src_install() {                               
	cd ${S}
	dojar mysql-jdbc.jar

	dohtml -r doc/*
}



