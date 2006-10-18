# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-jaybird/jdbc-jaybird-2.1.0.ebuild,v 1.3 2006/10/18 13:59:40 wltjr Exp $

inherit eutils java-pkg-2

At="Jaybird-${PV/_/}-src"
DESCRIPTION="JDBC Type 2 and 4 drivers for Firebird SQL server"
HOMEPAGE="http://jaybirdwiki.firebirdsql.org/"
SRC_URI="mirror://sourceforge/firebird/${At}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples source test"

RDEPEND=">=virtual/jre-1.4
		dev-java/log4j"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		dev-java/ant-core
		dev-java/cpptasks
		${RDEPEND}
		test? ( dev-java/junit )
		source? ( app-arch/zip )"

S="${WORKDIR}/client-java"

MY_PN="jaybird"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	echo "${S}"
	epatch "${FILESDIR}/archive-xml-${PV}.patch"
	epatch "${FILESDIR}/compile-xml-${PV}.patch"
	rm "${S}"/lib/*.jar
	cd "${S}/src/lib/"
	# the build.xml unpacks this and uses stuff
	mv mini-j2ee.jar ${T} || die "Failed to move mini-j2ee.jar to ${T}"
	rm *.jar
	mv ${T}/mini-j2ee.jar . || die "Failed to move mini-j2ee.jar back from ${T}"

	java-pkg_jar-from log4j log4j.jar log4j-core.jar
}

src_compile() {
	local antflags="jars compile-native"
	use doc && antflags="${antflags} javadocs"
	use examples && antflags="${antflags} -Dexamples=true"
	use test && antflags="${antflags} -Dtests=true"
	ant ${antflags} || die "Building failed."
}

src_install() {
	cd "${S}"/output/lib/
	java-pkg_newjar ${MY_PN}-${PV/_beta1}.jar ${PN}.jar || die "java-pkg_newjar ${MY_PN}.jar failed"

	for jar in full pool; do
		java-pkg_newjar ${MY_PN}-${jar}-${PV/_beta1}.jar ${MY_PN}-${jar}.jar || die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	done
	if use test; then
		java-pkg_newjar ${MY_PN}-test-${PV/_beta1}.jar ${MY_PN}-${jar}.jar || die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	fi

	cd "${S}"/output/native
	sodest="/usr/lib/"
	java-pkg_doso libjaybird21.so || die "java-pkg_doso ${sodest}libjaybird21.so failed"

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
	ant all-tests-pure-java || die "JUnit testing failed."
}
