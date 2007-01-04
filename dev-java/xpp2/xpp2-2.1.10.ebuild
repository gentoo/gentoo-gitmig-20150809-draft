# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xpp2/xpp2-2.1.10.ebuild,v 1.12 2007/01/04 05:54:17 tgall Exp $

inherit java-pkg

MY_PN="PullParser"
MY_P="${MY_PN}${PV}"
DESCRIPTION="A streaming pull XML parser used to quickly process input elements"
HOMEPAGE="http://www.extreme.indiana.edu/xgws/xsoap/xpp/mxp1/index.html"
SRC_URI="http://www.extreme.indiana.edu/xgws/xsoap/xpp/download/${MY_PN}2/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc jikes source"
S="${WORKDIR}/${MY_P}"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.6
	>=dev-java/xerces-2.7
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm lib/*/*.jar
	rm build/*/*.jar
}
src_compile() {
	local antflags="-lib $(java-pkg_getjars xerces-2) compile"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} api"
	ant ${antflags} || die "Compilation failed"
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

