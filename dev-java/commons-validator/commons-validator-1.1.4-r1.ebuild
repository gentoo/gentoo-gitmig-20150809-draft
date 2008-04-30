# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.1.4-r1.ebuild,v 1.10 2008/04/30 15:15:41 nixnut Exp $

JAVA_PKG_IUSE="doc examples source"
inherit java-pkg-2 java-ant-2

MY_P="${P}-src"
DESCRIPTION="Commons component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="mirror://apache/jakarta/commons/validator/source/${MY_P}.tar.gz
		 mirror://gentoo/${P}-gentoo-missingfiles.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

IUSE=""

CDEPEND="=dev-java/jakarta-oro-2.0*
	>=dev-java/commons-digester-1.5
	>=dev-java/commons-collections-3.1
	>=dev-java/commons-logging-1.0.3
	=dev-java/commons-beanutils-1.6*"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar || die

	#dirty hack
	sed -e 's:target name="compile" depends="static":target name="compile" depends="prepare":' -i build.xml \
		|| die "Failed to sed build.xml"

	echo "oro.jar=$(java-pkg_getjars jakarta-oro-2.0)" >> build.properties
	echo "commons-digester.jar=$(java-pkg_getjars commons-digester)" >> build.properties
	echo "commons-beanutils.jar=$(java-pkg_getjars commons-beanutils-1.6)" >> build.properties
}

src_compile() {
	local antflags="compile"

	# Because the build.xml file uses <pathelement location="">
	# we can only have only have one jar per property
	antflags="${antflags} -Dcommons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)"

	local col=$(java-pkg_getjar commons-collections	commons-collections.jar)
	eant ${antflags} $(use_doc) \
		-Dcommons-collections.jar="${col}" || die "build failed"
	jar -cf ${PN}.jar -C target/classes/ . || die "could not create jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dojavadoc dist/docs/api
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/share/org
}
