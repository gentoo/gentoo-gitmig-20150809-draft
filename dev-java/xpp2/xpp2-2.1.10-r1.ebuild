# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xpp2/xpp2-2.1.10-r1.ebuild,v 1.1 2006/08/05 17:27:29 nichoj Exp $

inherit java-pkg-2 java-ant-2

MY_PN="PullParser"
MY_P="${MY_PN}${PV}"
DESCRIPTION="Xml Pull Parser (in short XPP) is a streaming pull XML parser and should be used when there is a need to process quickly and efficiently all input elements (for example in SOAP processors)"
HOMEPAGE="http://www.extreme.indiana.edu/xgws/xsoap/xpp/mxp1/index.html"
SRC_URI="http://www.extreme.indiana.edu/xgws/xsoap/xpp/download/${MY_PN}2/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
S="${WORKDIR}/${MY_P}"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.6
	>=dev-java/xerces-2.6.2-r2"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm lib/*/*.jar
	rm build/*/*.jar
	find build/ -name '*.jar' -o -name '*.class' -delete
}

src_compile() {
	eant -lib $(java-pkg_getjars xerces-2) compile $(use_doc api)
}

src_install() {
	java-pkg_newjar build/lib/${MY_PN}-${PV}.jar ${MY_PN}.jar
	java-pkg_newjar build/lib/${MY_PN}-intf-${PV}.jar ${MY_PN}-intf.jar
	java-pkg_newjar build/lib/${MY_PN}-standard-${PV}.jar ${MY_PN}-standard.jar
	java-pkg_newjar build/lib/${MY_PN}-x2-${PV}.jar ${MY_PN}-x2.jar

	dohtml README.html
	use doc && java-pkg_dohtml -r doc/api
	use source && java-pkg_dosrc src/java/*
}

