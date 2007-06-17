# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jtds/jtds-1.2-r2.ebuild,v 1.4 2007/06/17 12:13:53 opfer Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="jTDS - SQL Server and Sybase JDBC driver"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://jtds.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
COMMON_DEPEND="
	=dev-java/jcifs-1*
	>=dev-java/junit-3.8"
# does not like javax.sql in >=1.6
DEPEND="
	|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	${COMMON_DEPEND}
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/1.0.3-buildxml.patch"
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1714497&group_id=33291&atid=407764
	epatch "${FILESDIR}/1.2-com.sun.patch"

	cd "${S}/lib"
	rm -v *.jar || die

	java-pkg_jar-from jcifs-1.1
	#TODO: don't always build tests
	java-pkg_jar-from junit
}

src_install() {
	java-pkg_dojar build/*.jar

	dodoc CHANGELOG README* || die "Failed to install docs."
	use doc && java-pkg_dojavadoc build/doc
	use source && java-pkg_dosrc ${S}/src/main/*
}
