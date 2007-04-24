# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jibx/jibx-1.1.3.ebuild,v 1.1 2007/04/24 09:56:39 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_all_version_separators '_')

DESCRIPTION="JiBX: Binding XML to Java Code"
HOMEPAGE="http://jibx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

COMMON_DEP="=dev-java/dom4j-1*
	dev-java/ant-core
	dev-java/bcel
	dev-java/xpp3"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${PN}"

src_unpack() {

	unpack ${A}

	cd "${S}/lib"
	rm -f *.jar

	java-pkg_jarfrom xpp3
	java-pkg_jarfrom bcel
	java-pkg_jarfrom ant-core
	java-pkg_jarfrom dom4j-1

}

EANT_BUILD_XML="build/build.xml"
EANT_BUILD_TARGET="small-jars jar-tools"

src_install() {

	cd "${S}/lib/"
	java-pkg_dojar "${S}/lib"/jibx-*.jar

	cd "${S}"
	dodoc changes.txt readme.html docs/binding.dtd docs/binding.xsd

	use doc && {
		java-pkg_dohtml -r docs/*
		cp -R starter "${D}/usr/share/doc/${PF}"
		cp -R tutorial "${D}/usr/share/doc/${PF}"
	}

	use source && java-pkg_dosrc ${S}/build/src/* ${S}/build/extras/*

}
