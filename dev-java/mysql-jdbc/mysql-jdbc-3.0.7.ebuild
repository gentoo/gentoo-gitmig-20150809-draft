# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mysql-jdbc/mysql-jdbc-3.0.7.ebuild,v 1.1 2003/04/26 09:24:52 robbat2 Exp $

longname=mysql-connector-java-${PV}-stable
S=${WORKDIR}/${longname}

SRC_URI="http://gd.tuwien.ac.at/db/mysql/Downloads/Connector-J/${longname}.tar.gz"
DESCRIPTION="Connector/J, the MySQL JDBC driver."
HOMEPAGE="http://www.mysql.com/products/connector-j/index.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND=">=virtual/jdk-1.2"
RDEPEND="${DEPEND}"

src_install() {
	dojar ${S}/${longname}-bin.jar
	dodoc ${S}/README ${S}/CHANGES ${S}/COPYING
	cp -a ${FILESDIR}/21mysql-jdbc ${S}/21mysql-jdbc
	insinto /etc/env.d
	insopts -m0755
	doins ${S}/21mysql-jdbc
}
