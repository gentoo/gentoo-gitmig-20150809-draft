# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-jaybird/jdbc-jaybird-2.1.0-r1.ebuild,v 1.6 2007/08/17 21:29:05 betelgeuse Exp $

JAVA_PKG_IUSE="doc source examples test"

inherit eutils java-pkg-2 java-ant-2

At="Jaybird-${PV/_/}-src"
DESCRIPTION="JDBC Type 2 and 4 drivers for Firebird SQL server"
HOMEPAGE="http://jaybirdwiki.firebirdsql.org/"
SRC_URI="mirror://sourceforge/firebird/${At}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="jni"

RDEPEND=">=virtual/jre-1.4
		dev-java/log4j"
DEPEND="|| ( =virtual/jdk-1.5* =virtual/jdk-1.4* )
		app-arch/unzip
		dev-java/log4j
		jni? ( dev-java/cpptasks )
		test? (
			dev-java/junit
			dev-java/ant-junit
		)"

S="${WORKDIR}/client-java"

MY_PN="jaybird"

# The build.xml breaks if -source gets rewritten
# This ebuild should probably have a java5 use flag
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/archive-xml-${PV}.patch"
	epatch "${FILESDIR}/compile-xml-${PV}.patch"

	cd "${S}/lib/"
	rm -v *.jar
	use test && java-pkg_jar-from --build-only junit junit.jar

	cd "${S}/src/lib/"
	# the build.xml unpacks this and uses stuff
	mv mini-j2ee.jar ${T} || die "Failed to move mini-j2ee.jar to ${T}"
	rm -v *.jar *.zip
	mv ${T}/mini-j2ee.jar . || die "Failed to move mini-j2ee.jar back from ${T}"

	java-pkg_jar-from log4j log4j.jar log4j-core.jar
}

src_compile() {
	java-pkg_filter-compiler jikes
	eant $(use test && echo "-Dtests=true") jars \
		$(use jni && echo "compile-native") \
		$(use_doc javadocs)
}

src_install() {
	cd "${S}/output/lib/"
	java-pkg_newjar ${MY_PN}-${PV}.jar ${PN}.jar

	for jar in full pool; do
		java-pkg_newjar ${MY_PN}-${jar}-${PV}.jar ${MY_PN}-${jar}.jar || die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	done
	if use test; then
		java-pkg_newjar ${MY_PN}-test-${PV}.jar ${MY_PN}-${jar}.jar || die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	fi

	if use jni; then
		cd "${S}/output/native"
		sodest="/usr/lib/"
		java-pkg_doso libjaybird21.so || die \
			"java-pkg_doso ${sodest}libjaybird21.so failed"
	fi

	cd "${S}"

	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples || die "installing examples failed"
	fi

	use source && java-pkg_dosrc "${S}"/src/*/org

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
	ANT_TASKS="ant-junit" eant all-tests-pure-java
}
