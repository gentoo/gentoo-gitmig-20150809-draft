# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jempbox/jempbox-0.2.0.ebuild,v 1.1 2007/04/24 23:23:43 caster Exp $

JAVA_PKG_IUSE="doc source test"
WANT_ANT_TASKS="ant-nodeps"
inherit java-pkg-2 java-ant-2

MY_PN="JempBox"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Java library that implements Adobe's XMP specification"
HOMEPAGE="http://www.jempbox.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/ant-junit =dev-java/junit-3* )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -v lib/*.jar
	rm -rf docs/javadoc

	if use test; then
		java-ant_xml-rewrite -f build.xml --change -e junit \
			-a haltonfailure -v true
		cd lib
		java-pkg_jar-from --build-only junit
	else
		# no way to separate building of tests in build.xml
		# at least it doesn't include them in <jar>
		rm -rf src/test
	fi
}

EANT_BUILD_TARGET="package"

src_test() {
	ANT_TASKS="ant-junit" eant junit
}

src_install() {
	java-pkg_newjar lib/${MY_P}.jar

	if use doc; then
		dohtml -r docs/*
		java-pkg_dojavadoc website/build/site/javadoc
	fi

	use source && java-pkg_dosrc src/org
}
