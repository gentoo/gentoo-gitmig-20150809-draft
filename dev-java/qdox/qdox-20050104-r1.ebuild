# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qdox/qdox-20050104-r1.ebuild,v 1.5 2007/05/13 18:23:19 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Parser for extracting class/interface/method definitions from source files with JavaDoc tags."
HOMEPAGE="http://qdox.codehaus.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="1.6" # it's the 1.6 codebase
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEP="dev-java/junit
	dev-java/ant-core"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

src_unpack() {

	unpack ${A}
	java-ant_rewrite-classpath "${S}/build.xml"

}

EANT_DOC_TARGET="docs"

src_compile() {

	EANT_EXTRA_ARGS="-Dgentoo.classpath=$(java-pkg_getjars junit,ant-core)"
	java-pkg-2_src_compile

}

src_install() {

	java-pkg_dojar dist/${PN}.jar
	dodoc README.txt

	use doc	&& java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/java/*

}
