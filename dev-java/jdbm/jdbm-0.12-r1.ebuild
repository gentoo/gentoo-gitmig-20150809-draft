# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbm/jdbm-0.12-r1.ebuild,v 1.4 2007/07/12 22:35:40 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Jdbm aims to be for Java what GDBM is for Perl, Python, C, ..."
HOMEPAGE="http://jdbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="BSD"
SLOT="1"
KEYWORDS="amd64 ~ppc x86"

COMMON_DEP="dev-java/jta
	=dev-java/xerces-1.3*"

# Needs to depend on 1.3 because this uses assert
# so we need -source 1.3 here.
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.3
	${COMMON_DEP}
	app-arch/unzip"

src_unpack() {
	unpack ${A}

	cd "${S}/src"
	epatch "${FILESDIR}/${P}-buildfile.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from jta
	java-pkg_jar-from xerces-2
}

src_compile() {
	cd "${S}/src"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dojavadoc build/doc/javadoc
	use source && java-pkg_dosrc src/main/*
}
