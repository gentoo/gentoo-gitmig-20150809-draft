# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-2.0.14.ebuild,v 1.1 2003/05/14 07:29:25 absinthe Exp $

inherit java-pkg

At=mysql-connector-java-${PV}
S=${WORKDIR}/${At}

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

RDEPEND=">=virtual/jdk-1.2"
DEPEND="${RDEPEND}"

src_compile() {
	einfo " This is a binary-only ebuild (for now)."
}

src_install() {
	java-pkg_dojar ${At}-bin.jar
	dodoc README CHANGES COPYING
}
