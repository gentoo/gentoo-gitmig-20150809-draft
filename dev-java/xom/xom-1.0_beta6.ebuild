# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xom/xom-1.0_beta6.ebuild,v 1.4 2004/10/22 11:51:48 absinthe Exp $

inherit java-pkg

XOMVER="xom-${PV/_beta/b}"
DESCRIPTION="XOM is a new XML object model. It is a tree-based API for processing XML with Java that strives for correctness and simplicity."
HOMEPAGE="http://cafeconleche.org/XOM/index.html"
SRC_URI="http://cafeconleche.org/XOM/${XOMVER}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=">=dev-java/ant-1.4
		>=dev-java/xerces-2.6.2-r1
		dev-java/xalan
		dev-java/junit
		dev-java/icu4j
		dev-java/tagsoup
		=dev-java/servletapi-2.3*"
RDEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}/XOM

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from junit
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	java-pkg_jar-from servletapi-2.3 servletapi-2.3.jar servlet.jar
	java-pkg_jar-from icu4j icu4j.jar normalizer.jar
	java-pkg_jar-from tagsoup
}

src_compile() {
	local antflags="jar -Ddebug=off -Dtagsoup.jar=lib/tagsoup.jar"
	ant ${antflags} || die "Failed Compiling"
}

src_install() {
	mv ${WORKDIR}/XOM/build/${XOMVER}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	dodoc Todo.txt

	if use doc ; then
		dodir /usr/share/doc/${P}
		cd ${WORKDIR}/XOM/
		java-pkg_dohtml -r apidocs/
	fi
}
