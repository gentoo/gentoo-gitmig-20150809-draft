# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.0.17.ebuild,v 1.2 2005/07/15 13:15:33 gustavoz Exp $

inherit eutils java-pkg

At=mysql-connector-java-${PV}-ga

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""
RDEPEND=">=virtual/jre-1.2
	dev-java/jta
	dev-java/log4j
	dev-java/jdbc2-stdext"
DEPEND=">=virtual/jdk-1.2
	${RDEPEND}
	dev-java/ant-core"

S=${WORKDIR}/${At}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar

	cd lib
	rm -f *.jar
	java-pkg_jar-from jta
	java-pkg_jar-from jdbc2-stdext
	java-pkg_jar-from log4j
}

src_compile() {
	local antflags="dist"
	ant ${antflags} || die "build failed!"
}

src_install() {
	java-pkg_newjar ${WORKDIR}/build-mysql-jdbc/${At}/${At}-bin.jar ${PN}.jar
	dodoc README CHANGES COPYING
}

