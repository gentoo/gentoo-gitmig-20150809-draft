# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.1.3.ebuild,v 1.4 2004/10/17 07:27:04 absinthe Exp $

inherit java-pkg

DESCRIPTION="Jakarta component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="mirror://apache/jakarta/commons/validator/source/${PN}-${PV}-src.tar.gz mirror://gentoo/commons-validator-1.1.3-gentoo-missingfiles.tar.bz2"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( >=junit-3.8.1 )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/oro-2.0.8
	>=dev-java/commons-digester-1.5
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.3
	>=dev-java/commons-beanutils-1.6
	>=dev-java/xerces-2.6.2-r1"
LICENSE="Apache-1.1"
SLOT="0"
RESTRICT="nomirror"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc jikes junit"

src_unpack() {
	unpack ${A}
	cd ${S}
	#dirty hack
	sed -e 's:target name="compile" depends="static":target name="compile" depends="prepare":' -i build.xml

	echo "oro.jar=`java-config --classpath=oro`" >> build.properties
	echo "commons-digester.jar=`java-config --classpath=commons-digester`" >> build.properties
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging | sed s/.*://`" >> build.properties
	echo "commons-beanutils.jar=`java-config --classpath=commons-beanutils | sed s/.*://`" >> build.properties
	echo "xerces.jar=`java-config --classpath=xerces-2`" >> build.properties
	use junit && echo "junit.jar=`java-config --classpath=junit`" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "build failed"
	jar -cvf ${PN}.jar -C target/classes/ . || die "could not create jar"
}

src_install() {
	cd ${S}
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/
	dohtml PROPOSAL.html STATUS.html
	dodoc LICENSE.txt
}
