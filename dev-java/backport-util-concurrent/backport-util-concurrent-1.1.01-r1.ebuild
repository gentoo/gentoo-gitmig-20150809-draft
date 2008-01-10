# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/backport-util-concurrent/backport-util-concurrent-1.1.01-r1.ebuild,v 1.7 2008/01/10 23:03:52 caster Exp $

JAVA_PKG_IUSE="doc source test"

inherit versionator java-pkg-2 java-ant-2

MY_PV="$(replace_version_separator 2 _)"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="This package is the backport of java.util.concurrent API, introduced in Java 5.0, to Java 1.4"
HOMEPAGE="http://www.mathcs.emory.edu/dcl/util/backport-util-concurrent/"
SRC_URI="http://www.mathcs.emory.edu/dcl/util/${PN}/dist/${MY_P}/${MY_P}-src.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEP=""
DEPEND="=virtual/jdk-1.4*
	${COMMON_DEP}
	test? ( =dev-java/junit-3.8* )"
RDEPEND="=virtual/jre-1.4*
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}-src"

src_unpack() {
	unpack ${A}
	use test || rm -fr "${S}"/test/tck/src/*
	cd "${S}/external"
	rm -v *.jar || die
	use test && java-pkg_jar-from --build-only junit
}

EANT_BUILD_TARGET="javacompile archive"

src_test() {
	eant test
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dohtml README.html || die
	use doc && java-pkg_dojavadoc doc/api
	use source && java-pkg_dosrc src/edu
}
