# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jibx-tools/jibx-tools-1.1.3.ebuild,v 1.1 2007/05/05 16:11:41 nelchael Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_all_version_separators '_')

DESCRIPTION="JiBX: Binding XML to Java Code - Generators"
HOMEPAGE="http://jibx.sourceforge.net/"
SRC_URI="mirror://sourceforge/jibx/jibx_${MY_PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

COMMON_DEP="=dev-java/dom4j-1*
	dev-java/ant-core
	dev-java/bcel
	dev-java/jsr173
	dev-java/xpp3"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	~dev-java/jibx-${PV}
	${COMMON_DEP}"

S="${WORKDIR}/jibx"

src_unpack() {

	unpack ${A}

	cd "${S}/lib"
	rm -f *.jar

	java-pkg_jarfrom ant-core
	java-pkg_jarfrom bcel
	java-pkg_jarfrom dom4j-1
	java-pkg_jarfrom jsr173
	java-pkg_jarfrom xpp3

}

EANT_BUILD_XML="build/build.xml"
EANT_BUILD_TARGET="jar-tools"

src_install() {

	java-pkg_register-dependency jibx

	cd "${S}/lib/"
	java-pkg_dojar "${S}/lib"/jibx-genbinding.jar
	java-pkg_dojar "${S}/lib"/jibx-genschema.jar

	use source && java-pkg_dosrc ${S}/build/src/* ${S}/build/extras/*

}
