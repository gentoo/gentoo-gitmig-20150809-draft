# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-fileupload/commons-fileupload-1.2.ebuild,v 1.1 2007/03/16 20:15:15 fordfrog Exp $

JAVA_PKG_IUSE="doc source"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="The Commons FileUpload package makes it easy to add robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://jakarta.apache.org/commons/fileupload/"
SRC_URI="mirror://apache/jakarta/commons/fileupload/source/${P}-src.tar.gz"
COMMON_DEPEND=">=dev-java/commons-io-1.1
	=dev-java/portletapi-1*
	~dev-java/servletapi-2.3"
DEPEND=">=virtual/jdk-1.3
	source? ( app-arch/unzip )
	!test? ( >=dev-java/ant-core-1.5 )
	test? (
		>=dev-java/ant-1.5
		=dev-java/junit-3.8*
	)
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEPEND}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Tweak build classpath and don't automatically run tests
	epatch "${FILESDIR}/${P}-gentoo.patch"
	local libdir="${S}/target/lib"
	mkdir -p ${libdir}/commons-io/jars -p  ${libdir}/javax.servlet/jars -p  ${libdir}/javax.portlet/jars
	java-pkg_jar-from --into ${libdir}/commons-io/jars commons-io-1 commons-io.jar commons-io-1.3.jar
	java-pkg_jar-from --into ${libdir}/javax.servlet/jars servletapi-2.3 servlet.jar servlet-api-2.3.jar
	java-pkg_jar-from --into ${libdir}/javax.portlet/jars portletapi-1 portletapi.jar portlet-api-1.0.jar
}

EANT_BUILD_TARGET="jar"
EANT_DOC_TARGET="javadoc"

src_test() {
	mkdir -p target/lib/junit/jars
	java-pkg_jar-from --into "${S}"/target/lib/junit/jars junit junit.jar junit-3.8.1.jar
	eant test
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs
	use source && java-pkg_dosrc src/java/*
}
