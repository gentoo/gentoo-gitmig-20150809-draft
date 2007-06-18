# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/freemarker/freemarker-2.3.10.ebuild,v 1.2 2007/06/18 17:29:04 flameeyes Exp $

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION=" FreeMarker is a template engine; a generic tool to generate text output based on templates."
HOMEPAGE="http://freemarker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="freemarker"
SLOT="2.3"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/javacc
	dev-java/jython
	=dev-java/servletapi-2.3*
	=dev-java/jaxen-1.1*"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

src_unpack() {

	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"

	cd "${S}/lib/"
	rm -f *.jar

	rm -f "${S}/src/freemarker/testcase/servlets/WEB-INF/taglib2.jar"
	rm -f "${S}/src/freemarker/testcase/servlets/WEB-INF/lib/taglib-foo.jar"

}

src_compile() {

	# BIG FAT WARNING:
	# clean target removes lib/ directory!!
	eant clean

	mkdir lib/
	cd lib/
	java-pkg_jar-from servletapi-2.3
	java-pkg_jar-from jaxen-1.1
	java-pkg_jar-from jython

	cd "${S}"
	eant jar $(use_doc) -Djavacc.home=/usr/share/javacc/lib

}

src_install() {

	java-pkg_dojar lib/${PN}.jar
	dodoc README.txt || die

	use doc && java-pkg_dojavadoc build/api
	use source && java-pkg_dosrc src/*

}
