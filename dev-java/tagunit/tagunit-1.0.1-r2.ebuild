# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagunit/tagunit-1.0.1-r2.ebuild,v 1.1 2008/03/22 01:41:00 betelgeuse Exp $

EAPI=1
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="TagUnit is a tag library for testing custom tags within JSP pages."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://www.tagunit.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEP="
	java-virtuals/servlet-api:2.4
	>=dev-java/ant-core-1.6"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND="=virtual/jdk-1.4*
	${COMMON_DEP}
	test? ( dev-java/ant-junit:0 )
	app-arch/unzip"

S="${WORKDIR}/${P}-src/tagunit-core"

src_unpack() {
	unpack ${A}
	cd "${S}"

	echo ${PV} > ../version.txt
	mkdir ../lib || die
	cd ../lib || die
	java-pkg_jar-from ant-core
	java-pkg_jar-from --virtual servlet-api-2.4
}

EANT_BUILD_TARGET="build"
EANT_TEST_JUNIT_INTO="../lib"

src_install() {
	java-pkg_dojar lib/${PN}.jar
	cd "${S}/.."
	dodoc changes.txt readme.txt || die
	use doc && java-pkg_dojavadoc tagunit-core/doc/api
	use source && java-pkg_dosrc tagunit-core/src/*
}
