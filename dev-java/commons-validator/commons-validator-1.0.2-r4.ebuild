# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.0.2-r4.ebuild,v 1.1 2005/03/29 16:48:58 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Jakarta component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="mirror://apache/jakarta/commons/validator/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	app-arch/zip
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3
	=dev-java/jakarta-oro-2.0*
	>=dev-java/commons-digester-1.0
	>=dev-java/commons-collections-2.0
	>=dev-java/commons-logging-1.0
	>=dev-java/commons-beanutils-1.0
	>=dev-java/xerces-2.6.2-r1"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc examples jikes source"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "oro.jar=`java-config -p jakarta-oro-2.0`" >> build.properties
	echo "commons-digester.jar=`java-config -p commons-digester`" >> build.properties
	echo "commons-collections.jar=`java-config -p commons-collections`" >> build.properties
	echo "commons-logging.jar=`java-config -p commons-logging | sed s/.*://`" >> build.properties
	echo "commons-beanutils.jar=`java-config -p commons-beanutils`" >> build.properties
	echo "xerces.jar=`java-config -p xerces-2`" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "build failed"
}

src_install() {
	# Dirty hack
	mv ${S}/target/conf/MANIFEST.MF ${S}/target/classes/
	cd ${S}/target/classes
	zip -qr ../${PN}.jar org

	cd ${S}
	java-pkg_dojar target/${PN}.jar
	if use doc; then
		java-pkg_dohtml -r dist/docs/
		java-pkg_dohtml PROPOSAL.html STATUS.html
		dodoc RELEASE-NOTES.txt
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/example/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/share/*
}
