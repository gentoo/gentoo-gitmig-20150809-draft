# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.6.2-r2.ebuild,v 1.3 2005/03/21 23:38:35 luckyduck Exp $

inherit java-pkg eutils

IUSE="doc jikes examples source"

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="mirror://apache/xml/xerces-j/Xerces-J-src.${PV}.tar.gz"
LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="~x86 ~amd64"

DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/ant-core-1.5.2
	>=dev-java/xalan-2.5.2
	>=dev-java/xml-commons-1.0_beta2
	>=dev-java/xml-commons-resolver-1.1
	>=dev-java/xjavac-20041208"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.patch
	epatch ${FILESDIR}/${P}-javadoc.patch

	mkdir ${S}/tools
	cd ${S}/tools
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from ant-core ant-launcher.jar
	java-pkg_jar-from junit
	java-pkg_jar-from xalan
	java-pkg_jar-from xml-commons xml-apis.jar
	java-pkg_jar-from xml-commons-resolver xml-commons-resolver.jar resolver.jar


	mkdir ${S}/tools/bin
	cd ${S}/tools/bin
	java-pkg_jar-from xjavac-1
}

src_compile() {
	local antflags="jars sampjar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	sh build.sh ${antflags} || die "Compile failed."
}

src_install() {
	java-pkg_dojar build/x*.jar

	dodoc TODO STATUS README ISSUES LICENSE
	java-pkg_dohtml Readme.html

	use doc && java-pkg_dohtml -r build/docs/javadocs
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r samples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc ${S}/src/*
}
