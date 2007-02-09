# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-3.0.1.ebuild,v 1.4 2007/02/09 22:08:30 fordfrog Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P=${P/_/-}
DESCRIPTION="The Jakarta Commons HttpClient library"
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples test"

COMMON_DEPEND="
	dev-java/commons-logging
	dev-java/commons-codec"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.4
	sys-apps/sed
	test? (
		=dev-java/junit-3.8*
		dev-java/ant
	)
	!test? ( >=dev-java/ant-core-1.4 )
	source? ( app-arch/zip )
	${COMMON_DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	mkdir lib && cd lib
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-codec
}

src_compile() {
	eant dist $(use_doc) $(use test && echo "-Dtest.entry=true")
}

src_test() {
	java-pkg_jar-from --into lib junit
	eant test
}

src_install() {
	java-pkg_dojar dist/${PN}.jar dist/${PN}-contrib.jar
	use doc && java-pkg_dojavadoc dist/docs
	use source && java-pkg_dosrc src/java/* src/contrib/*

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}
