# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-service-wrapper/java-service-wrapper-3.3.1.ebuild,v 1.1 2008/09/06 21:28:17 ali_bush Exp $

WANT_ANT_TASKS="ant-nodeps"
JAVA_PKG_IUSE="doc source test"
inherit base java-pkg-2 java-ant-2 eutils

MY_PN="wrapper"
MY_P="${MY_PN}_${PV}_src"
DESCRIPTION="A wrapper that makes it possible to install a Java Application as daemon."
HOMEPAGE="http://wrapper.tanukisoftware.org/"
SRC_URI="http://${MY_PN}.tanukisoftware.org/download/${PV}/${MY_P}.zip"

LICENSE="java-service-wrapper"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"

DEPEND=">=virtual/jdk-1.4
		test? (
			dev-java/ant-junit
			=dev-java/junit-3*
		)"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	java-pkg-2_pkg_setup

	BITS="32"
	use amd64 && BITS="64"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# TODO file upstream

	use x86 && sed -i -e 's|gcc -O3 -Wall --pedantic|$(CC) $(CFLAGS) -fPIC|g' \
		"src/c/Makefile-linux-x86-${BITS}.make"
	use amd64 && sed -i -e 's|gcc -O3 -fPIC -Wall --pedantic|$(CC) $(CFLAGS) -fPIC|g' \
		"src/c/Makefile-linux-x86-${BITS}.make"

	java-ant_rewrite-classpath
}

src_compile() {
	tc-export CC
	eant -Dbits=${BITS} jar compile-c $(use_doc -Djdoc.dir=api)
}

src_test() {
	java-pkg_jar-from --build-only --into lib junit
	local gentoo.cp="gentoo.classpath=$(java-pkg_get-jars --build-only junit)"
	ANT_TASKS="ant-junit ant-nodeps" eant -Dbits="${BITS}" test
}

src_install() {
	java-pkg_dojar lib/wrapper.jar
	java-pkg_doso lib/libwrapper.so

	dobin bin/wrapper
	dodoc doc/{readme.txt,revisions.txt}

	use doc && java-pkg_dojavadoc api
	use source && java-pkg_dosrc src/java/*
}
