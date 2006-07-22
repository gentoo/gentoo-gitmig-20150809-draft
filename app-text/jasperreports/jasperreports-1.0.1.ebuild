# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jasperreports/jasperreports-1.0.1.ebuild,v 1.4 2006/07/22 21:28:44 dertobi123 Exp $

inherit java-pkg

DESCRIPTION="JasperReports is a powerful report-generating tool."
HOMEPAGE="http://jasperreports.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="jikes doc"

COMMONDEP="
	=dev-java/jcommon-1.0*
	=dev-java/jfreechart-1.0*
	=dev-java/eclipse-ecj-3.1*
	>=dev-java/poi-2.5
	>=dev-java/ant-core-1.4
	>=dev-java/itext-1.02
	=dev-java/commons-beanutils-1.6*
	>=dev-java/commons-collections-3.1
	>=dev-java/commons-digester-1.5
	>=dev-java/commons-logging-1.0.4
	~dev-java/servletapi-2.3
	>=dev-java/xalan-2.5.2
	>=dev-java/xerces-2.6.2-r1"
DEPEND=">=virtual/jdk-1.4
	>=app-arch/unzip-5.50
	${COMMONDEP}
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4
	${COMMONDEP}"

src_unpack() {
	unpack ${A}
	cd ${S}

	rm -f ${S}/dist/*.jar
	rm -f ${S}/lib/*.jar

	cd ${S}/lib
	java-pkg_jar-from itext iText.jar
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from commons-beanutils-1.6 commons-beanutils.jar
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-logging
	java-pkg_jar-from poi poi.jar
	java-pkg_jar-from servletapi-2.3
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	java-pkg_jar-from jcommon-1.0
	java-pkg_jar-from jfreechart-1.0
	java-pkg_jar-from eclipse-ecj-3.1
}

src_compile() {
	# we need clean here because it seems to be already compiled
	local antflags="clean jar"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar
	java-pkg_newjar dist/${P}-applet.jar ${PN}-applet.jar

	use doc && java-pkg_dohtml -r docs/*
}
