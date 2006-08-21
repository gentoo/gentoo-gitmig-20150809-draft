# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-ivy/ant-ivy-1.3.1.ebuild,v 1.1 2006/08/21 17:50:39 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PN=${PN##*-}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Ivy is a free java based dependency manager, with powerful features such as transitive dependencies, ant integration, maven repository compatibility, continuous integration, html reports and many more."
HOMEPAGE="http://jayasoft.org/ivy"
SRC_URI="http://jayasoft.org/downloads/ivy/1.3.1/${MY_P}-src.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )
	=dev-java/commons-cli-1*
	=dev-java/commons-httpclient-3*
	dev-java/commons-logging
	=dev-java/jakarta-oro-2.0*"
RDEPEND=">=virtual/jre-1.4
	${DEPEND}"

S=${WORKDIR}/${MY_P}

# Rewrites examples... bad
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${MY_P}-noresolve.patch"
	epatch "${FILESDIR}/${MY_P}-tasks.patch"

	mkdir ${S}/lib
	cd ${S}/lib
	java-pkg_jar-from commons-cli-1,commons-httpclient-3,commons-logging,ant-core,jakarta-oro-2.0

	cd ${S}
	java-ant_bsfix_one build.xml
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"

	eant ${antflags} || die "Ant failed"
}

src_install() {
	java-pkg_dojar build/artifact/${MY_PN}.jar
	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${MY_PN}.jar /usr/share/ant-core/lib/${PN}.jar
	use doc && java-pkg_dohtml -r build/doc/api
	use source && java-pkg_dosrc src/java/*
}

src_test() {
	eant test || die "Junit tests failed"
}
