# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mysql-jdbc/mysql-jdbc-2.0.14.ebuild,v 1.3 2003/02/13 10:22:12 vapier Exp $

A="mm.mysql-${PV}-you-must-unjar-me.jar"
S=${WORKDIR}/mm.mysql-${PV}

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/mmmysql/mm.mysql-${PV}-you-must-unjar-me.jar"
DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://mmmysql.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"

RDEPEND=">=virtual/jdk-1.2"
DEPEND="${RDEPEND}"

src_unpack() {
	jar xf ${DISTDIR}/${A}
}

src_install() {
	dojar mm.mysql-${PV}-bin.jar
	dodoc README CHANGES COPYING
}
