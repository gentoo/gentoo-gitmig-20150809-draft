# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/connectorj/connectorj-3.0.16.ebuild,v 1.3 2005/04/06 07:14:12 s4t4n Exp $

inherit java-pkg

DESCRIPTION="Connector/J: A MySQL JDBC connector"
HOMEPAGE="http://dev.mysql.com/downloads/connector/j/3.0.html"
SRC_URI="http://mysql.mirrors.key2network.com/Downloads/Connector-J/mysql-connector-java-${PV}-ga.tar.gz"
LICENSE="GPL-2"
SLOT="3"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/mysql-connector-java-${PV}-ga

src_compile() {
	ant || die "Failed to compile"
}

src_install() {
	java-pkg_dojar mysql-connector-java-${PV}-ga-bin.jar

	dodoc COPYING CHANGES README
	use doc && cp docs/connector-j-en.pdf ${D}/usr/share/doc/${PF}/
}
