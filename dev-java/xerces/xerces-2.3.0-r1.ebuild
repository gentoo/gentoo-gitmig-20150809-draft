# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.3.0-r1.ebuild,v 1.9 2005/03/23 18:22:45 gustavoz Exp $

inherit java-pkg eutils

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="http://xml.apache.org/dist/xerces-j/Xerces-J-src.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="~x86 ~amd64 ~sparc"

DEPEND=">=virtual/jdk-1.3
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/ant-core-1.5.2
	>=dev-java/xalan-2.5.2
	dev-java/xjavac
	>=dev-java/xml-commons-1.0_beta2"
IUSE="doc jikes source"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	mkdir ${S}/tools && cd ${S}/tools
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from ant-core ant-launcher.jar
	java-pkg_jar-from xalan
	java-pkg_jar-from xml-commons xml-apis.jar

	mkdir ${S}/tools/bin && cd ${S}/tools/bin
	java-pkg_jar-from xjavac-1
}

src_compile() {
	local antflags="jars"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	sh build.sh ${antflags} || die "ant build failed"
}

src_install () {
	java-pkg_dojar build/x*.jar
	dodoc TODO STATUS README LICENSE ISSUES
	dohtml Readme.html

	if use doc; then
		dodir /usr/share/doc/${PF}
		cp -a samples ${D}/usr/share/doc/${PF}
		java-pkg_dohtml -r build/docs/javadocs
	fi
	if use source; then
		java-pkg_dosrc ${S}/src/*
	fi
}
