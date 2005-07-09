# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.3.0-r1.ebuild,v 1.12 2005/07/09 15:56:13 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="http://xml.apache.org/dist/xerces-j/Xerces-J-src.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="x86 amd64 sparc ~ppc"
IUSE="doc examples jikes source"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/xml-commons-1.0_beta2"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.5.2
	>=dev-java/xjavac-20041208-r1
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )
	${RDEPEND}"

S=${WORKDIR}/xerces-${PV//./_}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	mkdir ${S}/tools && cd ${S}/tools
	java-pkg_jar-from xml-commons xml-apis.jar

	mkdir ${S}/tools/bin && cd ${S}/tools/bin
	java-pkg_jar-from xjavac-1
}

src_compile() {
	local antflags="jars"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install () {
	java-pkg_dojar build/x*.jar

	dodoc TODO STATUS README ISSUES
	java-pkg_dohtml Readme.html

	if use doc; then
		java-pkg_dohtml -r build/docs/javadocs
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -a samples/* ${D}/usr/share/doc/${PF}
	fi
	use source && java-pkg_dosrc ${S}/src/*
}
