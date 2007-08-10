# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/axion/axion-1.0_rc2-r3.ebuild,v 1.5 2007/08/10 18:25:03 wltjr Exp $

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java RDMS with SQL and JDBC"
HOMEPAGE="http://axion.tigris.org/"
SRC_URI="http://axion.tigris.org/releases/1.0M2/axion-1.0-M2-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/javacc
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-primitives-1.0
	dev-java/commons-logging
	>=dev-java/commons-codec-1.2
	>=dev-java/log4j-1.2
	=dev-java/jakarta-regexp-1.3*"

RDEPEND="|| (
		=virtual/jre-1.5*
		=virtual/jre-1.4* )
	${COMMON_DEP}"
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4* )
	${COMMON_DEP}"

S="${WORKDIR}/${PN}-1.0-M2"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/commons-codec.patch"

	echo javacc.home=/usr/share/javacc/lib/ > build.properties

	mkdir lib test
	cd lib
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-primitives
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-codec
	java-pkg_jar-from log4j
	java-pkg_jar-from jakarta-regexp-1.3

	cd "${S}/"
	# These files are re-created by javacc, if they are not removed the compile
	# will fail:
	rm -f \
		src/org/axiondb/parser/TokenMgrError.java \
		src/org/axiondb/parser/ParseException.java \
		src/org/axiondb/parser/Token.java \
		src/org/axiondb/parser/SimpleCharStream.java \
			|| die

}

EANT_BUILD_TARGET="compile jar"

src_install() {

	java-pkg_newjar bin/axion-1.0-M2.jar ${PN}.jar

	use doc && java-pkg_dojavadoc bin/docs/api
	use source && java-pkg_dosrc src/*

}
