# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.0.2-r1.ebuild,v 1.2 2004/04/05 04:59:48 zx Exp $

inherit java-pkg

DESCRIPTION="Jakarta component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="mirror://apache/jakarta/commons/validator/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/oro-2.0.6
	>=dev-java/commons-digester-1.0
	>=dev-java/commons-collections-2.0
	>=dev-java/commons-logging-1.0
	>=dev-java/commons-beanutils-1.0
	>=dev-java/xerces-2.0.1
	app-arch/unzip
	jikes? ( dev-java/jikes )
	junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
RESTRICT="nomirror"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="doc jikes junit"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "oro.jar=`java-config --classpath=oro`" >> build.properties
	echo "commons-digester.jar=`java-config --classpath=commons-digester`" >> build.properties
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging | sed s/.*://`" >> build.properties
	echo "commons-beanutils.jar=`java-config --classpath=commons-beanutils`" >> build.properties
	echo "xerces.jar=`java-config --classpath=xerces`" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags}
}

src_install() {
	# Dirty hack
	mv ${S}/target/conf/MANIFEST.MF ${S}/target/classes/
	cd ${S}/target/classes
	zip -qr ../${PN}.jar org

	cd ${S}
	java-pkg_dojar target/${PN}.jar
	use doc && dohtml -r dist/docs/
	dohtml PROPOSAL.html STATUS.html
	dodoc RELEASE-NOTES.txt
}
