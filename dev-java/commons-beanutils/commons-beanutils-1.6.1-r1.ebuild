# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.6.1-r1.ebuild,v 1.10 2005/01/20 18:12:46 luckyduck Exp $

inherit java-pkg

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta BeanUtils component provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://jakarta.apache.org/commons/beanutils.html"
SRC_URI="mirror://apache/jakarta/commons/beanutils/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc jikes"

src_compile() {
	local myc

	cp ${S}/LICENSE.txt LICENSE
	cd ${S}

	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties

	if use jikes ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	ANT_OPTS=${myc} ant jar || die "Compilation Failed"

	if use doc ; then
		ANT_OPTS=${myc} ant javadoc || die "Unable to create documents"
	fi
}

src_install () {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc RELEASE-NOTES.txt LICENSE
	dohtml STATUS.html PROPOSAL.html

	if use doc ; then
		java-pkg_dohtml -r dist/docs/*
	fi
}
