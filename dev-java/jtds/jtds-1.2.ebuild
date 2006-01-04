# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jtds/jtds-1.2.ebuild,v 1.1 2006/01/04 00:12:56 betelgeuse Exp $

inherit eutils java-pkg

DESCRIPTION="jTDS - SQL Server and Sybase JDBC driver"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://jtds.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6.2
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/jcifs-1.1*
	>=dev-java/junit-3.8"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/1.0.3-buildxml.patch

	cd ${S}/lib
	rm -f *.jar

	java-pkg_jar-from jcifs-1.1
	java-pkg_jar-from junit
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"

	if use doc; then
		mv build/doc build/api || die "Failed to rename doc."
	fi
}

src_install() {
	java-pkg_dojar build/*.jar

	dodoc CHANGELOG README* || die "Failed to install docs."
	use doc && java-pkg_dohtml -r build/api
	use source && java-pkg_dosrc ${S}/src/main/*
}
