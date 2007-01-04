# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xpp3/xpp3-1.1.3.4m.ebuild,v 1.7 2007/01/04 05:56:17 tgall Exp $

inherit java-pkg

MY_PV="1.1.3.4.M"
MY_P=${PN}-${MY_PV}

DESCRIPTION="An implementation of XMLPULL V1 API."
HOMEPAGE="http://www.extreme.indiana.edu/xgws/xsoap/xpp/mxp1/index.html"
SRC_URI="http://www.extreme.indiana.edu/dist/java-repository/xpp3/distributions/${MY_P}_src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64"
IUSE="doc jikes junit source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	junit? ( dev-java/junit )
	jikes? ( dev-java/jikes )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${MY_P}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} junit"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	cp build/${MY_P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r doc/
	use source && java-pkg_dosrc src/java/*
}
