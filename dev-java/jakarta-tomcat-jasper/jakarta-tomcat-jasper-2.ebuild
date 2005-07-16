# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-tomcat-jasper/jakarta-tomcat-jasper-2.ebuild,v 1.3 2005/07/16 11:30:12 axxo Exp $

inherit eutils java-pkg

TOMCAT_PV="5.0.28"
DESCRIPTION="Jasper 2 is the Tomcat JSP Engine"
HOMEPAGE="http://jakarta.apache.org/tomcat"
SRC_URI="mirror://apache/jakarta/tomcat-5/v${TOMCAT_PV}/src/jakarta-tomcat-${TOMCAT_PV}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"

RDEPEND=">=virtual/jdk-1.4
	=dev-java/servletapi-2.4*
	=dev-java/xerces-1.3*
	=dev-java/xerces-2.6*
	dev-java/xml-commons
	dev-java/commons-collections
	dev-java/commons-daemon
	dev-java/commons-el
	dev-java/commons-logging
	dev-java/commons-launcher"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S=${WORKDIR}/jakarta-tomcat-${TOMCAT_PV}-src/${PN}/jasper2

src_unpack() {
	unpack ${A}
	cd ${S}

	# Setup build.properties
	echo "servlet-api.jar=$(java-pkg_getjar servletapi-2.4 servlet-api.jar)" >> build.properties
	echo "jsp-api.jar=$(java-pkg_getjar servletapi-2.4 jsp-api.jar)" >> build.properties
	echo "ant.jar.jar=$(java-pkg_getjar ant-core ant.jar)" >> build.properties
	echo "xerces.jar=$(java-pkg_getjar xerces-1.3 xerces.jar)" >> build.properties
	echo "xercesImpl.jar=$(java-pkg_getjar xerces-2 xercesImpl.jar)" >> build.properties
	echo "xml-apis.jar=$(java-pkg_getjar xml-commons xml-apis.jar)" >> build.properties
	echo "commons-el.jar=$(java-pkg_getjar commons-el commons-el.jar)" >> build.properties
	echo "commons-collections.jar=$(java-pkg_getjar commons-collections	commons-collections.jar)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	echo "commons-daemon-launcher=$(java-pkg_getjar commons-daemon commons-daemon.jar)" >> build.properties
	echo "commons-launcher.jar=$(java-pkg_getjar commons-launcher commons-launcher.jar)" >> build.properties
}

src_compile() {
	antflags="build-main"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar ${S}/build/shared/lib/jasper-*.jar

	use doc && java-pkg_dohtml -r ${S}/build/javadoc
	use source && java-pkg_dosrc src/share/*
}
