# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.1.4.ebuild,v 1.2 2006/10/05 15:33:51 gustavoz Exp $

inherit java-pkg

MY_P=${P}-src
DESCRIPTION="Jakarta component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="mirror://apache/jakarta/commons/validator/source/${MY_P}.tar.gz
		 mirror://gentoo/${P}-gentoo-missingfiles.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="doc examples jikes source"

# Was not able to test on 1.3 jdk at this point. Feel free to to lower this
# back to 1.3 if you have tested it on one and proved working. Then you
# probably need to bring the xerces dependency back.

RDEPEND=">=virtual/jre-1.4
	=dev-java/jakarta-oro-2.0*
	>=dev-java/commons-digester-1.5
	>=dev-java/commons-collections-3.1
	>=dev-java/commons-logging-1.0.3
	=dev-java/commons-beanutils-1.6*"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4
	${RDEPEND}
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar
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
	antflags="${antflags} -Dcommons-collections.jar=$(java-pkg_getjars commons-collections)"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "build failed"
	jar -cf ${PN}.jar -C target/classes/ . || die "could not create jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	if use doc; then
		java-pkg_dohtml -r dist/docs/
		java-pkg_dohtml PROPOSAL.html STATUS.html
	fi

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/example/* ${D}/usr/share/doc/${PF}/examples
	fi

	use source && java-pkg_dosrc src/share/*
}
