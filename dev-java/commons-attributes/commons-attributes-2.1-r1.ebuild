# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-attributes/commons-attributes-2.1-r1.ebuild,v 1.4 2007/04/25 21:31:21 caster Exp $

JAVA_PKG_IUSE="doc source"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Commons Attributes enables Java programmers to use C#/.Net-style attributes in their code."
HOMEPAGE="http://jakarta.apache.org/commons/attributes/"
SRC_URI="mirror://apache/jakarta/commons/attributes/source/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/xjavadoc
	dev-java/gjdoc
	dev-java/ant-core"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.patch

	mkdir -p target/classes/org/apache/commons/attributes
	# This file is missing from upstream's release
	# and is needed to use the ant task.
	cp ${FILESDIR}/anttasks.properties target/classes/org/apache/commons/attributes/

	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from xjavadoc
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from gjdoc
}

src_install() {
	java-pkg_newjar target/${PN}-api-${PV}.jar ${PN}-api.jar
	java-pkg_newjar target/${PN}-compiler-${PV}.jar ${PN}-compiler.jar

	dodoc NOTICE.txt RELEASE.txt
	dohtml README.html

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc api/src/java/org compiler/src/java/org
}
