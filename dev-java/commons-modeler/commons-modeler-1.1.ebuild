# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-modeler/commons-modeler-1.1.ebuild,v 1.6 2004/11/28 11:45:16 axxo Exp $

inherit java-pkg

DESCRIPTION="A lib to make the setup of Java Management Extensions easier"
SRC_URI="mirror://apache/jakarta/commons/modeler/source/modeler-1.1-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/modeler/"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/jmx-1.2.1
		>=dev-java/commons-logging-1.0.3
		>=dev-java/commons-digester-1.4.1
		>=dev-java/xalan-2.5.1"
KEYWORDS="x86 ~amd64"
IUSE="doc jikes"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack "modeler-${PV}-src.tar.gz"
	cd ${S}

	# Setup the build environment
	echo "commons-digester.jar=`java-config --classpath=commons-digester | sed s/":"/"\n"/g | tail -n 1`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging | sed s/":"/"\n"/g | tail -n 1`" >> build.properties
	echo "jmx.jar=`java-config --classpath=jmx | sed s/":"/"\n"/g | head -n1`" >> build.properties
	echo "jmxtools.jar=`java-config --classpath=jmx | sed s/":"/"\n"/g | tail -n1`" >> build.properties
	echo "jaxp.xalan.jar=`java-config --classpath=xalan`" >> build.properties
	echo "junit.jar=`java-config --classpath=junit`" >> build.properties
	mkdir dist
}

src_compile() {
	antflags="prepare jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar dist/${PN}.jar  || die "Unable to install"
	dodoc LICENSE.txt RELEASE-NOTES-1.1.txt RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r docs/*
}
