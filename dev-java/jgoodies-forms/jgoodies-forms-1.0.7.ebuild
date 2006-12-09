# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-forms/jgoodies-forms-1.0.7.ebuild,v 1.3 2006/12/09 09:20:56 flameeyes Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PN="forms"
MY_PV=${PV//./_}
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A} || die "Unpack failed"
	cd ${S}

	# Remove the packaged jars
	rm *.jar || die "em failed"

	# No support for junit tests yet
	rm -rf ${S}/src/test

	# patch the build.xml:
	epatch "${FILESDIR}/${P}-build.xml.patch"
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar build/${MY_PN}.jar

	dodoc RELEASE-NOTES.txt README.html

	use doc && java-pkg_dohtml -r build/doc
	use source && java-pkg_dosrc src/{core,extras}/com
}
