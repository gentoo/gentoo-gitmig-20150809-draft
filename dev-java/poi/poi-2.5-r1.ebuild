# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/poi/poi-2.5-r1.ebuild,v 1.2 2004/10/22 11:35:29 absinthe Exp $

inherit java-pkg eutils

DESCRIPTION="Java API To Access Microsoft Format Files"
HOMEPAGE="http://jakarta.apache.org/poi/"
SRC_URI="mirror://apache/jakarta/poi/release/src/${PN}-src-${PV}-final-20040302.tar.gz"
IUSE="jikes junit"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND=">=virtual/jdk-1.2
		junit? ( dev-java/junit )
		sys-apps/sed
		>=dev-java/ant-1.4
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.2
		>=dev-java/commons-logging-1.0
		>=dev-java/log4j-1.2.8
		>=dev-java/commons-beanutils-1.6
		>=dev-java/commons-collections-2.1
		>=dev-java/commons-lang-1.0
		>=dev-java/xerces-2.6.2-r1"
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f src/contrib/lib/*.jar lib/*.jar
	use jikes && epatch ${FILESDIR}/${P}-jikes-fix.patch
	sed -e 's:<target name="init" depends="check-jars,fetch-jars">:<target name="init" depends="check-jars">:' -i build.xml

	cd ${S}/lib
	use junit && java-pkg_jar-from junit junit.jar junit-3.8.1.jar
	java-pkg_jar-from log4j log4j.jar log4j-1.2.8.jar
	java-pkg_jar-from commons-logging commons-logging.jar commons-logging-1.0.1.jar
	cd ${S}/src/contrib/lib
	java-pkg_jar-from commons-beanutils commons-beanutils.jar commons-beanutils-1.6.jar
	java-pkg_jar-from commons-collections commons-collections.jar commons-collections-2.1.jar
	java-pkg_jar-from commons-lang commons-lang.jar commons-lang-1.0-b1.jar
	java-pkg_jar-from xerces-2 xmlParserAPIs.jar xmlParserAPIs-2.2.1.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar xercesImpl-2.4.0.jar
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compile problem"
}

src_install() {
	cd build/dist/
	mv poi-scratchpad-${PV}* ${PN}-scratchpad.jar
	mv poi-contrib-${PV}* ${PN}-contrib.jar
	mv poi-${PV}* ${PN}.jar
	java-pkg_dojar *.jar
}
