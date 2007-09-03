# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjms/openjms-0.7.6.1-r2.ebuild,v 1.2 2007/09/03 06:09:55 opfer Exp $

JAVA_PKG_IUSE="doc"
WANT_ANT_TASKS="ant-antlr"

inherit java-pkg-2 java-ant-2 eutils

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Open Java Messaging System"
HOMEPAGE="http://openjms.sourceforge.net/"
KEYWORDS="~amd64 x86"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz mirror://gentoo/${P}-scripts.tar.gz"
IUSE=""
RDEPEND="=virtual/jre-1.4*
	dev-java/antlr
	=dev-java/castor-0.9*
	dev-java/cdegroot-db
	dev-java/commons-collections
	dev-java/commons-dbcp
	dev-java/commons-logging
	dev-java/commons-pool
	dev-java/concurrent-util
	dev-java/exolabcore
	dev-db/hsqldb
	dev-java/jdbm
	dev-java/sun-jms
	dev-java/jta
	dev-java/log4j
	=dev-java/jakarta-oro-2.0*
	~dev-java/servletapi-2.3
	=dev-java/xerces-2.3*"
DEPEND="=virtual/jdk-1.4*
	${RDEPEND}
	dev-java/ant-core"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/bin" "${S}"
	mv "${WORKDIR}/config" "${S}"

	cd "${S}"
	epatch "${FILESDIR}/${PV}/buildfile.patch"
	epatch "${FILESDIR}/${PV}/source.patch"

	cd "${S}/lib"
	rm -f *.jar

	java-pkg_jar-from antlr
	java-pkg_jar-from castor-0.9
	java-pkg_jar-from cdegroot-db-1
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-dbcp
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-pool
	java-pkg_jar-from concurrent-util
	java-pkg_jar-from exolabcore
	java-pkg_jar-from hsqldb
	java-pkg_jar-from jdbm-1
	java-pkg_jar-from sun-jms
	java-pkg_jar-from jta
	java-pkg_jar-from log4j
	java-pkg_jar-from servletapi-2.3
	java-pkg_jar-from xerces-2.3
	java-pkg_jar-from jakarta-oro-2.0
}

src_compile() {
	eant jar war
}

src_install() {
	java-pkg_newjar lib/${P}.jar ${PN}.jar
	java-pkg_newjar lib/${PN}-client-${PV}.jar ${PN}-client.jar
	java-pkg_dowar lib/${PN}.war

	dodir /opt/${PN}
	cp -rP {bin,config,lib} ${D}/opt/${PN}/
	#use doc && cp -rP {docs,src} ${D}/opt/${PN}/

	fperms 755 /opt/${PN}/bin/*
	newenvd ${FILESDIR}/${PV}/10${P} 10${PN}
	newinitd ${FILESDIR}/${PV}/rc2 openjms
	newconfd ${FILESDIR}/${PV}/conf openjms
}
