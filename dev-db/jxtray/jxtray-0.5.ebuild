# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/jxtray/jxtray-0.5.ebuild,v 1.3 2005/02/03 17:14:46 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Java based Database Explorer"
HOMEPAGE="http://jxtray.sourceforge.net"
SRC_URI="mirror://sourceforge/jxtray/${PN}-src-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes firebird mssql mysql postgres"

DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	~dev-java/jdom-1.0_beta9
	dev-java/sax
	dev-java/poi
	>=dev-java/xerces-2.6.2
	dev-java/xml-commons
	>=dev-java/kunststoff-2.0.2
	jikes? ( >=dev-java/jikes-1.21 )
	firebird? ( dev-java/jdbc3-firebird )
	mssql? ( =dev-java/jtds-0.9* )
	mysql? ( dev-java/jdbc-mysql )
	postgres? ( dev-java/jdbc3-postgresql )
	!firebird? ( !mssql? ( !postgres? ( dev-java/jdbc-mysql ) ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-src-${PV}"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build.xml ${FILESDIR}/default.properties ${S}
	local cp=""

	cd ${S}/lib
	rm *.jar
	cp="${cp}:`java-config -p jdom-1.0_beta9`"
	cp="${cp}:`java-config -p xerces-2`"
	cp="${cp}:`java-config -p sax`"
	cp="${cp}:`java-config -p poi`"
	cp="${cp}:`java-config -p xml-commons`"

	cd ${S}/lib/lookandfeel
	rm *.jar
	cp="${cp}:`java-config -p kunststoff-2.0`"

	cd ${S}/lib/drivers
	rm *.jar
	use firebird && cp="${cp}:`java-config -p jdbc3-firebird`"
	use mssql && cp="${cp}:`java-config -p jtds-0.9`"
	use mysql && cp="${cp}:`java-config -p jdbc-mysql`"
	use postgres && cp="${cp}:`java-config -p jdbc3-postgres`"

	echo "classpath=${cp}" > ${S}/build.properties
}

src_compile() {
	local antflags="jar"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compile failed!"
}

src_install() {
	local cp="java-config -p jxtray,jdom-1.0_beta9,xerces-2,sax,poi,xml-commons,kunststoff-2.0"

	use firebird && cp="${cp},jdbc3-firebird"
	use mssql && cp="${cp},jtds-0.9"
	use mysql && cp="${cp},jdbc-mysql"
	use postgres && cp="${cp},jdbc3-postgres"

	java-pkg_dojar ${S}/dist/${PN}-${PV}.jar

	echo "#!/bin/sh" > ${PN}
	echo "java -cp \$(${cp}) jxtray.Jxtray" >> ${PN}
	dobin ${PN}

	dodoc CHANGELOG.txt LICENSE.txt README.txt
	use doc && java-pkg_dohtml -r ${S}/javadoc/*
}
