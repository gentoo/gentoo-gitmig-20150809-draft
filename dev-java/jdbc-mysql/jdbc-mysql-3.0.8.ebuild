# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.0.8.ebuild,v 1.2 2004/01/17 04:10:19 strider Exp $

inherit java-pkg

At=mysql-connector-java-${PV}-stable
S=${WORKDIR}/${At}

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=virtual/jdk-1.2"
DEPEND="${RDEPEND}"

src_compile() {
	einfo " This is a binary-only ebuild (for now)."
}

src_install() {
	java-pkg_dojar ${At}-bin.jar
	dodoc README CHANGES COPYING
}
