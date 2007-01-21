# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rome/rome-0.9.ebuild,v 1.2 2007/01/21 18:13:38 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="An open source set of Atom/RSS Java utilities that make it easy to work in Java with most syndication formats"
HOMEPAGE="https://rome.dev.java.net/"
SRC_URI="https://rome.dev.java.net/source/browse/*checkout*/rome/www/dist/${P}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc source test"

COMMON_DEPEND=">=dev-java/jdom-1.0"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	source? ( app-arch/zip )
	test? (
		dev-java/ant
		=dev-java/junit-3.8*
	)
	!test? ( dev-java/ant-core )
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch build.xml so the tests pass
	epatch ${FILESDIR}/${P}-build.xml-test-upstream.patch

	# Symlink jars
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from jdom-1.0
	use test && java-pkg_jar-from junit
}

src_install() {
	java-pkg_newjar target/${P}.jar

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}

src_test() {
	eant test
}
