# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.0.2.ebuild,v 1.2 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

S="${WORKDIR}/${P}-src"
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
	junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="doc jikes junit"

src_compile() {
	echo "oro.jar=`java-config --classpath=oro`" >> build.properties
	echo "commons-digester.jar=`java-config --classpath=commons-digester`" >> build.properties
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties
	echo "commons-beanutils.jar=`java-config --classpath=commons-beanutils`" >> build.properties
	echo "xerces.jar=`java-config --classpath=xerces`" >> build.properties
	jakarta-commons_src_compile myconf make

	# UGLY HACK
	mv ${S}/target/conf/MANIFEST.MF ${S}/target/classes/
	cd ${S}/target/classes
	zip -r ../${PN}-${PV}.jar org

	jakarta-commons_src_install dojar
	use doc && jakarta-commons_src_compile makedoc
	use doc && jakarta-commons_src_install html
}
