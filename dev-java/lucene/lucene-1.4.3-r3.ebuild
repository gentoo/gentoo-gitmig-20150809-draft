# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.4.3-r3.ebuild,v 1.3 2007/08/10 07:49:21 wltjr Exp $

JAVA_PKG_IUSE="doc examples source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="mirror://apache/jakarta/lucene/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=virtual/jdk-1.4
	test? (
		=dev-java/junit-3*
		dev-java/ant-junit
	)"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}

	cd "${S}/lib" || die
	rm -v *.jar || die
}

src_compile() {
	eant jar-core $(use_doc javadocs)
}

src_test() {
	java-pkg_jar-from --into lib junit
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	dodoc CHANGES.txt README.txt || die
	java-pkg_newjar build/lucene-1.5-rc1-dev.jar

	if use doc; then
		dohtml -r docs/*
		java-pkg_dojavadoc build/docs/api
	fi
	use examples && java-pkg_doexamples src/demo
	use source && java-pkg_dosrc src/java/org
}
