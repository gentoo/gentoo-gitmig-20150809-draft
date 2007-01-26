# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-jaybird/jdbc-jaybird-1.5.6.ebuild,v 1.3 2007/01/26 16:19:38 wltjr Exp $

inherit eutils java-pkg-2

At="FirebirdSQL-${PV}-src"
DESCRIPTION="JDBC3 driver for Firebird SQL server"
HOMEPAGE="http://firebird.sourceforge.net"
SRC_URI="mirror://sourceforge/firebird/${At}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples test source"

COMMON_DEPEND="dev-java/log4j
				dev-java/concurrent-util"
RDEPEND="|| ( =virtual/jre-1.3 =virtual/jre-1.4* )
		${COMMON_DEPEND}"
DEPEND="|| ( =virtual/jdk-1.3 =virtual/jdk-1.4* )
		app-arch/unzip
		test? (
			dev-java/junit
			dev-java/ant
		)
		!test? ( dev-java/ant-core )
		source? ( app-arch/zip )
		${COMMON_DEPEND}"

S="${WORKDIR}/client-java"

MY_PN="firebirdsql"

pkg_setup() {
	JAVA_PKG_WANT_SOURCE="1.2"
	JAVA_PKG_WANT_TARGET="1.2"
}

src_unpack() {
	unpack "${A}"

	cd "${S}/lib/"
	use test && java-pkg_jar-from --build-only junit junit.jar

	cd "${S}/src/lib/"
	rm *.jar *.zip
	java-pkg_jar-from concurrent-util
	java-pkg_jar-from log4j log4j.jar log4j-core.jar
}

src_compile() {
	java-pkg_filter-compiler jikes
	eant $(use test && echo "-Dtests=true") jars  $(use_doc javadocs)
}

src_install() {
	cd "${S}/output/lib"
	rm mini*.jar
	java-pkg_dojar *.jar

	if use test; then
		java-pkg_newjar ${MY_PN}-test.jar || die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	fi

	cd "${S}"
	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples || die "installing examples failed"
	fi

	use source && java-pkg_dosrc "${S}"/src/*/org

	dodoc ChangeLog

	cd "${S}/output"
	use doc && java-pkg_dohtml -r docs/
	dodoc etc/{*.txt,default.mf}
	dohtml etc/*.html
}

src_test() {
	#
	# Warning about timeouts without Firebird installed and running Locally
	#
	ewarn "You will experience long timeouts when running junit tests"
	ewarn "without Firebird installed and running locally. The tests will"
	ewarn "complete without Firebird, but network timeouts prolong the"
	ewarn "testing phase considerably."
	eant all-tests-pure-java
}
