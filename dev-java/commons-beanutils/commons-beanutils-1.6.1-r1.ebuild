# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.6.1-r1.ebuild,v 1.1 2004/01/21 02:48:49 strider Exp $

inherit java-pkg

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta BeanUtils component provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://jakarta.apache.org/commons/beanutils.html"
SRC_URI="mirror://apache/jakarta/commons/beanutils/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="jikes junit"

src_compile() {
	local myc

	cp ${S}/LICENSE.txt LICENSE
	cd ${S}

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	if [ -n "`use junit`" ] ; then
		echo "junit.jar=`java-config --classpath=junit`" | sed  s/:.*// >> build.properties
		ANT_OPTS=${myc} ant test || die "Testing Classes Failed"
	fi

	ANT_OPTS=${myc} ant jar || die "Compilation Failed"

	if [ -n "`use doc`" ] ; then
		ANT_OPTS=${myc} ant javadoc || die "Unable to create documents"
	fi
}

src_install () {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc RELEASE-NOTES.txt LICENSE
	dohtml STATUS.html PROPOSAL.html
	dohtml -r dist/docs/*
}
