# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmock/jmock-1.1.0.ebuild,v 1.1 2006/12/22 22:27:42 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Library for testing Java code using mock objects."
SRC_URI="http://${PN}.codehaus.org/${P}-src.zip"
HOMEPAGE="http://jmock.codehaus.org"
LICENSE="BSD"
SLOT="1.0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples source"

COMMON_DEPEND="
	=dev-java/cglib-2.0*
	=dev-java/junit-3*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch "${FILESDIR}/1.1.0-build.xml.patch"
	epatch "${FILESDIR}/1.1.0-junit-3.8.2.patch"

	cd ${S}/lib
	rm -v *.jar
	java-pkg_jar-from cglib-2
	java-pkg_jar-from junit
}

EANT_BUILD_TARGET="core.jar cglib.jar"

src_test() {
	eant core.test.unit cglib.test.unit
}

src_install() {
	java-pkg_newjar build/dist/jars/jmock-SNAPSHOT.jar jmock.jar
	java-pkg_newjar build/dist/jars/jmock-cglib-SNAPSHOT.jar jmock.jar
	dodoc CHANGELOG
	dohtml overview.html

	use doc && java-pkg_dojavadoc build/javadoc-*
	use source && java-pkg_dosrc core/src/org
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}
