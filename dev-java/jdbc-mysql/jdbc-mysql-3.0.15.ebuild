# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.0.15.ebuild,v 1.1 2004/10/20 11:40:35 absinthe Exp $

inherit java-pkg

At=mysql-connector-java-${PV}-ga

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""
RDEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}/${At}

src_compile() { :; }

src_install() {
	java-pkg_dojar ${At}-bin.jar
	dodoc README CHANGES COPYING
}
