# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-1.0.3.ebuild,v 1.1 2007/01/06 14:10:55 fordfrog Exp $

inherit java-pkg-2 java-ant-2 versionator

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~x86 ~amd64"
IUSE="doc source test"
COMMON_DEPEND="
	>=dev-java/itext-1.4.6
	>=dev-java/jcommon-1.0.0
	=dev-java/servletapi-2.3*"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}
	dev-java/ant-core
	test? ( =dev-java/junit-3.8* )"
RDEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}"

src_unpack() {
	unpack "${A}"

	cd "${S}/ant"
	epatch ${FILESDIR}/${P}-build.xml.patch

	cd "${S}"
	rm -f lib/* *.jar
	cd "${S}/lib"
	java-pkg_jar-from itext iText.jar itext-1.4.6.jar
	java-pkg_jar-from jcommon-1.0 jcommon.jar jcommon-1.0.6.jar
	java-pkg_jar-from servletapi-2.3
	use test && java-pkg_jar-from junit
}

src_compile() {
	eant -f ant/build.xml compile compile-experimental $(use_doc)
}

src_test() {
	ANT_TASKS="ant-junit" eant -f ant/build.xml test
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	java-pkg_newjar ${P}-experimental.jar ${PN}-experimental.jar
	dodoc README.txt CHANGELOG.txt
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc source/org
}

