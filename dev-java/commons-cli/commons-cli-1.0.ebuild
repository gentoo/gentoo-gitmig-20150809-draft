# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-cli/commons-cli-1.0.ebuild,v 1.1 2003/03/16 06:59:59 absinthe Exp $

S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="Jakarta-Commons library for working with command line arguments and options"
HOMEPAGE="http://jakarta.apache.org/commons/cli/index.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/${PN}/v${PV}/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=ant-1.4
		>=dev-java/junit-3.7"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="jikes junit"

src_compile() {
	local myc

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
	use doc && dohtml -r dist/docs/*
}
