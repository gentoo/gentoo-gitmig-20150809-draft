# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.0.1.ebuild,v 1.1 2002/12/27 00:33:30 strider Exp $

S="${WORKDIR}/validator-${PV}-src"
DESCRIPTION="Jakarta component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/${PN}/v${PV}/validator-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/oro-2.0.6
	>=dev-java/commons-digester-1.0
	>=dev-java/commons-collections-2.0
	>=dev-java/commons-logging-1.0
	>=dev-java/commons-beanutils-1.0
	>=dev-java/xerces-2.0.1
	junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes junit"

src_compile() {
	local myc

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	if [ -n "`use junit`" ] ; then
		echo "junit.jar=`java-config --classpath=junit`" | sed s/:.*// > build.properties
		ANT_OPTS=${myc} ant test || die "Testing Classes Failed"
	fi

	echo "oro.jar=`java-config --classpath=oro`" >> build.properties
	echo "commons-digester.jar=`java-config --classpath=commons-digester`" >> build.properties
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties
	echo "commons-beanutils.jar=`java-config --classpath=commons-beanutils`" >> build.properties
	echo "xerces.jar=`java-config --classpath=xerces`" >> build.properties

	ANT_OPTS=${myc} ant dist || die "Compilation Failed"
}

src_install () {
	dodoc RELEASE-NOTES.txt
	dojar dist/${PN}*.jar || die "Unable to install"
	dohtml -r dist/docs/*
	dohtml PROPOSAL.html STATUS.html
}
