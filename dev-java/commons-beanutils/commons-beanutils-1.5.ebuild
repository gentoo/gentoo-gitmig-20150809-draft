# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.5.ebuild,v 1.1 2002/11/06 18:27:09 strider Exp $

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta BeanUtils component provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://jakarta.apache.org/commons/beanutils.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/${PN}/v${PV}/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2
	junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes junit"

src_compile() {
	local myc

	cp beanutils/LICENSE.txt LICENSE

	cd beanutils
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

#   FIXME: THIS ACTUALLY IS NOT WORKING

#	if [ -n "`use junit`" ] ; then
#		echo "junit.jar=`java-config --classpath=junit`" >> build.properties
#		ANT_OPTS=${myc} ant test || die "Testing Classes Failed"
#	fi

	ANT_OPTS=${myc} ant jar || die "Compilation Failed"
	ANT_OPTS=${myc} ant javadoc || die "Unable to create documents"
}

src_install () {
	cd beanutils
	mv dist/${PN}*.jar dist/${PN}-${PV}.jar
	dojar dist/${PN}-${PV}.jar || die "Unable to install"
	dodoc RELEASE-NOTES.txt
	dohtml STATUS.html PROPOSAL.html
	dohtml -r dist/docs/*
}

pkg_postinst() {
	einfo "************* Documentation can be found at **************\n
	WEB: ${HOMEPAGE}\n
	LOCAL: /usr/share/doc/${PF}\n
   **********************************************************"
}
