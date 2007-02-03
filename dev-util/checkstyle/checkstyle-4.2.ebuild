# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/checkstyle/checkstyle-4.2.ebuild,v 1.3 2007/02/03 23:01:27 beandog Exp $

inherit java-pkg-2 java-ant-2

MY_P="${PN}-src-${PV}"
DESCRIPTION="A development tool to help programmers write Java code that adheres to a coding standard."
HOMEPAGE="http://checkstyle.sourceforge.net"
SRC_URI="mirror://sourceforge/checkstyle/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source test"

COMMON_DEP="dev-java/antlr
	=dev-java/commons-beanutils-1.7*
	=dev-java/commons-cli-1*
	dev-java/commons-logging"

RDEPEND="!test? ( >=virtual/jre-1.4 )
	test? ( >=virtual/jre-1.5 )
	${COMMON_DEP}"

# Uses antlr and as such needs ant-tasks
# Tests only pass with 1.5 but I think that
# is a problem with the test classes so running
# with 1.6 should be fine
DEPEND="!test? ( >=virtual/jdk-1.4 )
	test? ( =virtual/jdk-1.5* )
	${COMMON_DEP}
	dev-java/ant-core
	dev-java/ant-tasks
	test? (
		dev-java/junit
		dev-java/emma
	)"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm *.jar
	java-pkg_jar-from antlr
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from commons-logging
}

src_compile() {
	eant compile.checkstyle $(use_doc)
	jar cfm ${PN}.jar config/manifest.mf -C target/checkstyle . || die "jar failed"
}

src_test() {
	cd "${S}/lib"
	java-pkg_jar-from --build-only junit
	# for some weird classpath interactions both seem to be needed
	java-pkg_jar-from --build-only emma
	cd "${S}"
	local cp=$(java-pkg_getjar --build-only emma emma.jar)
	eant run.tests -lib "${cp}"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	dodoc README RIGHTS.antlr || die
	use doc && java-pkg_dojavadoc target/docs/api
	use source && java-pkg_dosrc src/${PN}/com

	# Install check files
	insinto /usr/share/checkstyle/checks
	for file in *.xml; do
		[[ "${file}" != build.xml ]] && doins ${file}
	done

	# Install extra files
	insinto  /usr/share/checkstyle/contrib
	doins -r contrib/*

	java-pkg_dolauncher ${PN} \
		--main com.puppycrawl.tools.checkstyle.Main

	# Make the ant tasks available to ant
	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/
}

pkg_postinst() {
	elog "Checkstyle is located at /usr/bin/checkstyle"
	elog "Check files are located in /usr/share/checkstyle/checks/"
}
