# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.0-r1.ebuild,v 1.2 2003/02/13 10:07:48 vapier Exp $

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/dbcp.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/${PN}/v${PV}/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.0.1"
RDEPEND=">=virtual/jre-1.3
		>=dev-java/commons-pool-1.0.1"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes"

src_compile() {
	local myc

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-pool.jar=`java-config --classpath=commons-pool`" >> build.properties

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	cp LICENSE.txt ../LICENSE
	ANT_OPTS=${myc} ant dist || die "Compilation failed"
}

src_install () {
	dojar dist/${PN}*.jar || die "Unable to install"
	dohtml PROPOSAL.html STATUS.html
	dohtml -r dist/docs/*
}
