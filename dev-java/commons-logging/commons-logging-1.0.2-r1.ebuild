# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-logging/commons-logging-1.0.2-r1.ebuild,v 1.8 2003/04/26 05:36:58 strider Exp $

S="${WORKDIR}/${P}-src"
DESCRIPTION="The Jakarta-Commons Logging package is an ultra-thin bridge between different logging libraries."
HOMEPAGE="http://jakarta.apache.org/commons/logging.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/${PN}/v${PV}/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes junit"

src_compile() {
	local myc

	cd logging
	cp LICENSE.txt ../LICENSE

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	if [ -n "`use junit`" ] ; then
		echo "junit.jar=`java-config --classpath=junit`" | sed s/:.*// > build.properties
		ANT_OPTS=${myc} ant test || die "Testing Classes Failed"
	fi

	echo "log4j.jar=`java-config --classpath=log4j`" >> build.properties

	ANT_OPTS=${myc} ant dist || die "Compilation failed"
}

src_install () {
	cd logging
	dojar dist/commons-logging-api.jar || die "Unable to install"
	dojar dist/commons-logging.jar || die "Unable to install"
	dodoc RELEASE-NOTES.txt
	dohtml PROPOSAL.html STATUS.html usersguide.html
	dohtml -r dist/docs/*
}
