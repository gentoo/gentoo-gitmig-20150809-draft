# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-1.3.1-r2.ebuild,v 1.4 2007/05/30 08:49:26 opfer Exp $

inherit java-pkg-2 java-ant-2

S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="http://archive.apache.org/dist/xml/xerces-j/old_xerces1/Xerces-J-src.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="1.3"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=">=virtual/jdk-1.3
	source? ( app-arch/zip )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/xalan-2.5.2"
IUSE="doc source"


src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/${P}-build.xml build.xml
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	eant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc README STATUS
	java-pkg_dohtml Readme.html
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc ${S}/src/org
}
