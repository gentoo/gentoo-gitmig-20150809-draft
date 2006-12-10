# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/jxtray/jxtray-0.5-r1.ebuild,v 1.1 2006/12/10 22:26:52 wltjr Exp $

inherit java-pkg-2

DESCRIPTION="Java based Database Explorer"
HOMEPAGE="http://jxtray.sourceforge.net"
SRC_URI="mirror://sourceforge/jxtray/${PN}-src-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc firebird mssql mysql postgres"

RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.5* )
	>=dev-java/jdom-1.0_beta9
	>=dev-java/kunststoff-2.0.2
	dev-java/poi
	dev-java/sax
	>=dev-java/xerces-2.7
	dev-java/xml-commons
	firebird? ( dev-java/jdbc-jaybird )
	mssql? ( =dev-java/jtds-0.9* )
	mysql? ( dev-java/jdbc-mysql )
	postgres? ( dev-java/jdbc3-postgresql )
	!firebird? ( !mssql? ( !postgres? ( dev-java/jdbc-mysql ) ) )"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.5* )
	${RDEPEND}
	dev-java/ant-core"

S="${WORKDIR}/${PN}-src-${PV}"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build.xml ${FILESDIR}/default.properties ${S}
	local cp=""

	cd ${S}/lib
	rm *.jar
	cp="${cp}:$(java-pkg_getjars jdom-1.0_beta9)"
	cp="${cp}:$(java-pkg_getjars xerces-2)"
	cp="${cp}:$(java-pkg_getjars xml-commons)"
	cp="${cp}:$(java-pkg_getjars sax)"
	cp="${cp}:$(java-pkg_getjars poi)"

	cd ${S}/lib/lookandfeel
	rm *.jar
	cp="${cp}:$(java-pkg_getjars kunststoff-2.0)"

	cd ${S}/lib/drivers
	rm *.jar
	use firebird && cp="${cp}:$(java-pkg_getjars jdbc-jaybird)"
	use mssql && cp="${cp}:$(java-pkg_getjars jtds-0.9)"
	use mysql && cp="${cp}:$(java-pkg_getjars jdbc-mysql)"
	use postgres && cp="${cp}:$(java-pkg_getjars jdbc3-postgresql)"

	echo "classpath=${cp}" > ${S}/build.properties
}

src_compile() {
	eant jar $(use_doc javadocs)
}

src_install() {
	local cp="java-config -p jxtray,jdom-1.0_beta9,xerces-2,xml-commons,sax,poi,kunststoff-2.0"

	use firebird && cp="${cp},jdbc-jaybird"
	use mssql && cp="${cp},jtds-0.9"
	use mysql && cp="${cp},jdbc-mysql"
	use postgres && cp="${cp},jdbc3-postgresql"

	java-pkg_newjar ${S}/dist/${P}.jar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "java -cp \$(${cp}) jxtray.Jxtray" >> ${PN}
	dobin ${PN}

	dodoc CHANGELOG.txt README.txt
	use doc && java-pkg_dohtml -r ${S}/javadoc/*
}
