# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-modeler/commons-modeler-1.1.ebuild,v 1.13 2005/07/10 13:41:13 axxo Exp $

inherit java-pkg

DESCRIPTION="A lib to make the setup of Java Management Extensions easier"
SRC_URI="mirror://apache/jakarta/commons/modeler/source/modeler-1.1-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/modeler/"
LICENSE="Apache-1.1"
SLOT="0"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/jmx-1.2.1
	>=dev-java/commons-logging-1.0.3
	>=dev-java/commons-digester-1.4.1
	>=dev-java/xalan-2.5.1"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )
	jikes? ( dev-java/jikes )"

KEYWORDS="amd64 ppc64 ~sparc x86"
IUSE="doc jikes source"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}

	# Setup the build environment
	echo "commons-digester.jar=$(java-pkg_getjar commons-digester commons-digester.jar)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	echo "jmx.jar=$(java-pkg_getjar jmx jmxri.jar)" >> build.properties
	echo "jmxtools.jar=$(java-pkg_getjar jmx jmxtools.jar)" >> build.properties
	echo "jaxp.xalan.jar=$(java-pkg_getjars xalan)" >> build.properties
	echo "junit.jar=$(java-pkg_getjars junit)" >> build.properties
	mkdir dist
}

src_compile() {
	local antflags="prepare jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar dist/${PN}.jar
	dodoc RELEASE-NOTES-1.1.txt RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
