# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-modeler/commons-modeler-1.1-r3.ebuild,v 1.1 2006/12/07 20:40:38 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A lib to make the setup of Java Management Extensions easier"
SRC_URI="mirror://apache/jakarta/commons/modeler/source/modeler-1.1-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/modeler/"
LICENSE="Apache-1.1"
SLOT="0"

# Provides ant tasks for ant to use
RDEPEND=">=virtual/jre-1.4
	=dev-java/mx4j-core-3*
	>=dev-java/commons-logging-1.0.3
	dev-java/ant-core
	commons-digester? ( >=dev-java/commons-digester-1.4.1 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )"

KEYWORDS="~x86"
IUSE="commons-digester doc source test"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/1.1-commons-digester.patch"

	# Setup the build environment
	use commons-digester && echo "commons-digester.jar=$(java-pkg_getjar commons-digester commons-digester.jar)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	echo "jmx.jar=$(java-pkg_getjar mx4j-core-3.0 mx4j.jar)" >> build.properties

	# This is something the build.xml tries to run. Could of course package it
	# separately using dolauncher. Use the demo target for this.
	#use examples && echo "jmxtools.jar=$(java-pkg_getjar mx4j-tools-3.0 mx4j-tools.jar)" >> build.properties

	#Probably only needed with 1.3
	#echo "jaxp.xalan.jar=$(java-pkg_getjars xalan)" >> build.properties
	mkdir dist
}

src_compile() {
	eant $(use_doc) prepare jar
}

src_test() {
	eant test -Djunit.jar=$(java-pkg_getjar --build-only junit junit.jar)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc RELEASE-NOTES-1.1.txt RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/*
}
pkg_postinst() {
	elog "Changed to mx4j from sun-jmx due to fetch restrictions"
	elog "If you don't like it tell us at java@gentoo.org"
}
