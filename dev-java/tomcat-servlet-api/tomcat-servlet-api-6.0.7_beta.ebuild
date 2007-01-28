# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tomcat-servlet-api/tomcat-servlet-api-6.0.7_beta.ebuild,v 1.4 2007/01/28 07:26:11 wltjr Exp $

inherit eutils java-pkg-2 java-ant-2

MY_A="apache-${P/_beta/}-src"
MY_P="${MY_A/-servlet-api/}"
DESCRIPTION="Tomcat's Servlet API 2.5/JSP API 2.1 implementation"
HOMEPAGE="http://tomcat.apache.org/"
SRC_URI="mirror://apache/jakarta/tomcat-6/v${PV/_/-}/src/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.5"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="source"

DEPEND="|| ( >=virtual/jdk-1.5 >=virtual/jdk-1.6 )
	>=dev-java/ant-core-1.5
	source? ( app-arch/zip )"
RDEPEND="|| ( >=virtual/jre-1.5 >=virtual/jre-1.6 )"

S="${WORKDIR}/${MY_P}/"

pkg_setup() {
	JAVA_PKG_WANT_SOURCE="1.5"
	JAVA_PKG_WANT_TARGET="1.5"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/${SLOT}-build.xml build.xml || die "Could not replace build.xml"
	rm */*/build.xml
}

src_compile() {
#	local antflags="jar $(use_doc javadoc examples)"
	local antflags="jar"
	eant ${antflags}
}

src_install() {
	cd ${S}/output/build/lib
	java-pkg_dojar *.jar
#	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc java/javax/servlet/
}
