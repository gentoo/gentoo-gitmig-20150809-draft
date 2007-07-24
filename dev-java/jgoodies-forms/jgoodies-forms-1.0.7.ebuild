# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-forms/jgoodies-forms-1.0.7.ebuild,v 1.8 2007/07/24 07:43:37 opfer Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils

MY_PN="forms"
MY_PV=${PV//./_}
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A} || die "Unpack failed"
	cd "${S}"

	# Remove the packaged jars
	rm -v *.jar || die "rm failed"

	# No support for junit tests yet
	rm -rf "${S}/src/test" || die

	# patch the build.xml:
	epatch "${FILESDIR}/${P}-build.xml.patch"
	java-pkg_filter-compiler jikes
}

# Comes in the tarball
EANT_DOC_TARGET=""

src_install() {
	java-pkg_dojar build/${MY_PN}.jar

	dodoc RELEASE-NOTES.txt README.html

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/{core,extras}/com
	use examples && java-pkg_doexamples src/tutorial
}
