# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-modeler/commons-modeler-1.1-r2.ebuild,v 1.1 2006/12/01 16:09:26 wltjr Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A lib to make the setup of Java Management Extensions easier"
SRC_URI="mirror://apache/jakarta/commons/modeler/source/modeler-1.1-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/modeler/"
LICENSE="Apache-1.1"
SLOT="0"
RDEPEND=">=virtual/jre-1.4
	=dev-java/mx4j-3*
	>=dev-java/commons-logging-1.0.3
	>=dev-java/commons-digester-1.4.1
	>=dev-java/xalan-2.5.1"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )"

KEYWORDS="~amd64 ~x86"
IUSE="doc source"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}

	# Setup the build environment
	echo "commons-digester.jar=$(java-pkg_getjar commons-digester commons-digester.jar)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	echo "jmx.jar=$(java-pkg_getjar mx4j-3.0 mx4j.jar)" >> build.properties
	echo "jmxtools.jar=$(java-pkg_getjar mx4j-3.0 mx4j-tools.jar)" >> build.properties
	echo "jaxp.xalan.jar=$(java-pkg_getjars xalan)" >> build.properties
	echo "junit.jar=$(java-pkg_getjars junit)" >> build.properties
	mkdir dist
}

src_compile() {
	local antflags="prepare jar"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc RELEASE-NOTES-1.1.txt RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
pkg_postinst() {
	einfo "Changed to mx4j from sun-jmx due to fetch restrictions"
	einfo "If you don't like it tell us at java@gentoo.org"
}
