# Copyright 2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/connectorj/connectorj-3.0.14.ebuild,v 1.1 2004/07/30 12:35:41 karltk Exp $

inherit java-pkg

DESCRIPTION="Connector/J: A MySQL JDBC connector"
HOMEPAGE="http://dev.mysql.com/downloads/connector/j/3.0.html"
SRC_URI="http://mysql.mirrors.key2network.com/Downloads/Connector-J/mysql-connector-java-3.0.14-production.tar.gz"
LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~x86"
IUSE="jikes"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5"
RDEPEND=">=virtual/jre-1.3"
S=${WORKDIR}/mysql-connector-java-${PV}-production

src_compile() {
	ant || die "Failed to compile"
}

src_install() {
	java-pkg_dojar mysql-connector-java-3.0.14-production-bin.jar

	dodoc COPYING CHANGES README
	cp docs/connector-j-en.pdf ${D}/usr/share/doc/${PF}/
}
