# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-forms/jgoodies-forms-1.0.7.ebuild,v 1.1 2006/08/02 21:12:50 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_V=${PV//./_}
DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/forms-${MY_V}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/forms-${PV}"

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
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "Compile failed"
}

src_install() {
	cd "${S}"
	java-pkg_dojar build/forms.jar

	dodoc RELEASE-NOTES.txt README.html

	use doc && java-pkg_dohtml -r build/doc
	use source && java-pkg_dosrc ${S}/com
}
