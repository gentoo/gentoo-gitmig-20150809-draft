# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jtds/jtds-1.0.2.ebuild,v 1.1 2005/02/18 16:01:57 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="Open source JDBC 3.0 Type 4 driver for Microsoft SQL Server (6.5,
7.0, 2000 and 2005) and Sybase."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://jtds.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="0.9"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/ant-1.6.2
	=dev-java/crimson-1.1*
	=dev-java/jcifs-1.1*
	>=dev-java/jta-1.0.1
	>=dev-java/junit-3.8"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-buildxml.patch

	cd ${S}/lib
	rm -f *

	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-tasks ant-junit.jar
	java-pkg_jar-from crimson-1
	java-pkg_jar-from jcifs-1.1
	java-pkg_jar-from jta
	java-pkg_jar-from junit

}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use source && antflags="${antflags} sourcezip"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar build/${PN}.jar

	dodoc CHANGELOG README LICENSE
	if use doc; then
		java-pkg_dohtml -r build/doc/*
	fi

	if use source; then
	    dodir /usr/share/doc/${PF}/source
		cp dist/${PN}-src.zip ${D}usr/share/doc/${PF}/source
	fi
}
