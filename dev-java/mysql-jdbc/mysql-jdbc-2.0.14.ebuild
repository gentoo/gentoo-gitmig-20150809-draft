# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mysql-jdbc/mysql-jdbc-2.0.14.ebuild,v 1.4 2003/03/27 02:05:09 seemant Exp $

S=${WORKDIR}/mm.mysql-${PV}

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://mmmysql.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/mmmysql/mm.mysql-${PV}-you-must-unjar-me.jar"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

RDEPEND=">=virtual/jdk-1.2"
DEPEND="${RDEPEND}"

src_unpack() {
	jar xf ${DISTDIR}/${A}
}

src_install() {
	dojar mm.mysql-${PV}-bin.jar
	dodoc README CHANGES COPYING
}
