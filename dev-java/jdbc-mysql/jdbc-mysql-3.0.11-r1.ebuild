# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.0.11-r1.ebuild,v 1.3 2004/10/23 07:04:06 absinthe Exp $

inherit eutils java-pkg

At=mysql-connector-java-${PV}-stable

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
RDEPEND=">=virtual/jdk-1.2
	dev-java/ant
	dev-java/jta
	dev-java/jdbc2-stdext"

S=${WORKDIR}/${At}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar

	cd lib
	rm -f *.jar
	java-pkg_jar-from jta || die "Failed to link jta"
	java-pkg_jar-from jdbc2-stdext || die "Failed to link jdbc2-stdext"
}

src_compile() {
	local antflags="dist"
	ant ${antflags} || die "build failed!"
}

src_install() {
	cp ${WORKDIR}/build-mysql-jdbc/${At}/${At}-bin.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	dodoc README CHANGES COPYING
}

