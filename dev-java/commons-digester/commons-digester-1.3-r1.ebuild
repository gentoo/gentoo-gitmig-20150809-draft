# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-digester/commons-digester-1.3-r1.ebuild,v 1.3 2002/12/15 16:19:49 strider Exp $

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta Digester component reads XML configuration files to provide initialization of various Java objects within the system."
HOMEPAGE="http://jakarta.apache.org/commons/digester.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/${PN}/v${PV}/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-beanutils-1.5
	>=dev-java/commons-collections-2.1
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/commons-beanutils-1.5
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes junit"

src_compile() {
	local myc

	cp digester/LICENSE.txt LICENSE
	cd digester

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-beanutils.jar=`java-config --classpath=commons-beanutils`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties


	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	if [ -n "`use junit`" ] ; then
		echo "junit.jar=`java-config --classpath=junit`" | sed  s/:.*// >> build.properties
		ANT_OPTS=${myc} ant test || die "Testing Classes Failed"
	fi

	ANT_OPTS=${myc} ant dist || die "Compilation Failed"
}

src_install () {
	cd digester
	dojar dist/${PN}*.jar || die "Unable to install"
	dodoc RELEASE-NOTES.txt
	dohtml STATUS.html PROPOSAL.html
	dohtml -r dist/docs/*
}
