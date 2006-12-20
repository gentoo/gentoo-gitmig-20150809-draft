# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qdox/qdox-20050104-r1.ebuild,v 1.3 2006/12/20 23:25:39 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Parser for extracting class/interface/method definitions from source files with JavaDoc tags."
HOMEPAGE="http://qdox.codehaus.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="1.6" # it's the 1.6 codebase
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/junit
	>=dev-java/ant-core-1.4"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	java-ant_rewrite-classpath "${S}/build.xml"
	eant -Dgentoo.classpath=$(java-pkg_getjars junit,ant-core) jar $(use_doc docs)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc README.txt

	use doc	&& java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/java/*
}
