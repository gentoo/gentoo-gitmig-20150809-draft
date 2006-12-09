# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xpp3/xpp3-1.1.3.4m-r1.ebuild,v 1.3 2006/12/09 09:27:21 flameeyes Exp $

inherit java-pkg-2 java-ant-2

MY_PV=${PV/m/.M}
MY_P=${PN}-${MY_PV}

DESCRIPTION="An implementation of XMLPULL V1 API."
HOMEPAGE="http://www.extreme.indiana.edu/xgws/xsoap/xpp/mxp1/index.html"
SRC_URI="http://www.extreme.indiana.edu/dist/java-repository/xpp3/distributions/${MY_P}_src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc test source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/junit )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${MY_P}

src_compile() {
	eant jar $(use_doc)
}

src_test() {
	eant junit
}

src_install() {
	cp build/${MY_P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r doc/
	use source && java-pkg_dosrc src/java/*
}
