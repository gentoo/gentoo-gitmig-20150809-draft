# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlunit/xmlunit-1.0-r2.ebuild,v 1.6 2007/08/15 21:08:15 wltjr Exp $

JAVA_PKG_IUSE="doc source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="XMLUnit extends JUnit and NUnit to enable unit testing of XML."
SRC_URI="mirror://sourceforge/${PN}/${P/-/}.zip"
HOMEPAGE="http://xmlunit.sourceforge.net/"
LICENSE="BSD"
SLOT="1"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
# We depend on jdk-1.4 as tests fail with jdk > 1.4
# see http://sourceforge.net/tracker/index.php?func=detail&aid=1614984&group_id=23187&atid=377768
# Also docs cannot be built with jdk > 1.5
CDEPEND="=dev-java/junit-3*"
DEPEND="
	app-arch/unzip
	!test? ( || ( =virtual/jdk-1.5* =virtual/jdk-1.4* ) )
	test? (
		=virtual/jdk-1.4*
		dev-java/ant-junit
		dev-java/ant-trax
	)
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-${PVR}-build.xml.patch"
	rm -v ${S}/lib/*.jar || die

	java-ant_rewrite-classpath
}

EANT_DOC_TARGET="docs"
EANT_GENTOO_CLASSPATH="junit"

src_test() {
	if use test; then
		ANT_TASKS="ant-junit ant-trax" eant test
	else
		echo "USE=test not enabled, skipping tests."
	fi
}

src_install() {
	java-pkg_newjar lib/${PN}${PV}.jar

	dodoc README.txt
	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc src/java/org
}

pkg_postinst() {
	elog "Please note that ${PN} has some problems with JDKs > 1.4. For details see:"
	elog "http://sourceforge.net/tracker/index.php?func=detail&aid=1614984&group_id=23187&atid=377768"
}
