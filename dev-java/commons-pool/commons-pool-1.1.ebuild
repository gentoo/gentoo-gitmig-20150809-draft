# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-pool/commons-pool-1.1.ebuild,v 1.3 2004/03/19 01:28:07 zx Exp $

inherit java-pkg

S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="Jakarta-Commons component providing general purpose object pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/pool.html"
SRC_URI="mirror://apache/jakarta/commons/pool/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.0
	junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-collections-2.0"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64"
IUSE="jikes junit doc"

src_compile() {
	local myc
	cd ${S}

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	if [ -n "`use junit`" ] ; then
		echo "junit.jar=`java-config --classpath=junit`" >> build.properties
		ANT_OPTS=${myc} ant || die "Testing Classes Failed"
	fi

	ANT_OPTS=${myc} ant dist || die "Compilation Failed"

	if [ -n "`use doc`" ] ; then
		ANT_OPTS=${myc} ant javadoc || die "Unable to create documents"
	fi
}

src_install () {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt
	dohtml STATUS.html PROPOSAL.html

	if [ -n "`use doc`" ] ; then
		dohtml -r dist/docs/*
	fi
}
