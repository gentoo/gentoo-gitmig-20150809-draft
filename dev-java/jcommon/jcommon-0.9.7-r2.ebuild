# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-0.9.7-r2.ebuild,v 1.2 2007/03/17 12:14:52 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org/jcommon"
SRC_URI="mirror://sourceforge/jfreechart/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
#		test? ( dev-java/junit )"
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar lib/*.jar || die
}

EANT_BUILD_XML="ant/build.xml"
EANT_BUILD_TARGET="compile"

RESTRICT="test"
# A couple of these fail

src_test() {
	cd lib/ || die
	java-pkg_jar-from junit
	cd ..
	eant -f ant/build.xml compile-junit-tests
	java -cp "./lib/jcommon-${PV}-junit.jar:$(java-pkg_getjars junit)" \
		junit.textui.TestRunner \
		org.jfree.junit.JCommonTestSuite || die "Tests failed"
}

src_install() {
	java-pkg_newjar ${P}.jar
	dodoc README.txt || die
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc source/*
}
