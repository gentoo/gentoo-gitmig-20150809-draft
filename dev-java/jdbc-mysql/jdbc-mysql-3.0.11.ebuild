# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.0.11.ebuild,v 1.2 2004/06/24 22:33:19 agriffis Exp $

inherit java-pkg

At=mysql-connector-java-${PV}-stable

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""
RDEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}/${At}

src_compile() { :; }

src_install() {
	java-pkg_dojar ${At}-bin.jar
	dodoc README CHANGES COPYING
}
