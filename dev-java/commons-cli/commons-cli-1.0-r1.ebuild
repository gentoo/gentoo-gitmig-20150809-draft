# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0-r1.ebuild,v 1.2 2003/04/26 05:36:58 strider Exp $

S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="Jakarta-Commons library for working with command line arguments and options"
HOMEPAGE="http://jakarta.apache.org/commons/cli/index.html"
SRC_URI="mirror://apache/jakarta/commons/cli/source/cli-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=ant-1.4
		>=dev-java/junit-3.7"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes junit"

src_compile() {
	local myc

	patch -d ${S} -p0 < ${FILESDIR}/${PN}-${PV}-gentoo.diff || die "Could not correct version in build.xml"

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	ANT_OPTS=${myc} ant jar || die "JAR compile failed"

	if [ -n "`use doc`" ]
	    then
	    ANT_OPTS=${myc} ant javadoc || die "Document compile failed"
	fi
}

src_install () {
	dojar target/*.jar || die "Unable to Install"
	use doc && dohtml -r target/docs/*
}
