# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/wsdl4j/wsdl4j-1.5.1-r1.ebuild,v 1.5 2007/06/22 12:05:28 angelos Exp $

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Web Services Description Language for Java Toolkit (WSDL4J)"
HOMEPAGE="http://wsdl4j.sourceforge.net"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.4"

EANT_BUILD_TARGET="compile"
EANT_DOC_TARGET="javadocs"

src_test() {
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_dojar build/lib/*.jar

	dohtml doc/*.html || die
	dodoc doc/spec/* || die

	use doc && java-pkg_dojavadoc build/javadocs/
	use source && java-pkg_dosrc src/*
}
