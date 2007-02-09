# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlunit/xmlunit-1.0-r2.ebuild,v 1.1 2007/02/09 23:27:50 fordfrog Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="XMLUnit extends JUnit and NUnit to enable unit testing of XML."
SRC_URI="mirror://sourceforge/${PN}/${P/-/}.zip"
HOMEPAGE="http://xmlunit.sourceforge.net/"
LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"
# We depend on jdk-1.4 as tests fail with jdk > 1.4
# see http://sourceforge.net/tracker/index.php?func=detail&aid=1614984&group_id=23187&atid=377768
# Also docs cannot be built with jdk > 1.5
DEPEND="=virtual/jdk-1.4*
	>=app-arch/unzip-5.50-r1
	test? (
		>=dev-java/ant-1.6
		=dev-java/junit-3.8*
		dev-java/xalan
	)
	!test? ( >=dev-java/ant-core-1.6 )
	source? ( app-arch/zip )"
RDEPEND="=virtual/jre-1.4*"
EANT_BUILD_TARGET="jar"
EANT_DOC_TARGET="docs"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PVR}-build.xml.patch
	rm -f ${S}/lib/*.jar
}

src_test() {
	eant test
}

src_install() {
	java-pkg_newjar lib/${PN}${PV}.jar ${PN}.jar

	dodoc README.txt
	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc src/java/*
}

pkg_postinst() {
	elog "Please note that ${PN} has some problems with JDKs > 1.4. For details see:"
	elog "http://sourceforge.net/tracker/index.php?func=detail&aid=1614984&group_id=23187&atid=377768"
}
