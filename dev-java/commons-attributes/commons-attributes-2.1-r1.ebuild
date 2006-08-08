# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-attributes/commons-attributes-2.1-r1.ebuild,v 1.2 2006/08/08 19:48:13 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Commons Attributes enables Java programmers to use C#/.Net-style attributes in their code."
HOMEPAGE="http://jakarta.apache.org/commons/attributes/"
SRC_URI="mirror://apache/jakarta/commons/attributes/source/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

COMMON_DEP="dev-java/xjavadoc"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.2
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
}

src_compile() {
	eant jar -Dnoget=true $(use_doc)
}

src_install() {
	java-pkg_newjar target/${PN}-api-${PV}.jar ${PN}-api.jar
	java-pkg_newjar target/${PN}-compiler-${PV}.jar ${PN}-compiler.jar

	dodoc NOTICE.txt RELEASE.txt
	dohtml README.html

	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc */src/java/*
}
