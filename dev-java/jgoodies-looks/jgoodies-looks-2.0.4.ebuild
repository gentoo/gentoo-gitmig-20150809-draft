# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-2.0.4.ebuild,v 1.2 2006/08/18 18:06:48 compnerd Exp $

inherit java-pkg-2 java-ant-2

MY_V=${PV//./_}

DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${MY_V}.zip"

LICENSE="BSD"
SLOT="2.0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4.2
		dev-java/ant-core
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.4.2"

S="${WORKDIR}/looks-${PV}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}

	# Clean up the structure
	rm -rf *.jar build.xml default.properties LICENSE.txt demo/ lib/

	# Copy the Gentoo'ized build.xml
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml
	cp ${FILESDIR}/plastic-${PV}.txt ${S}/plastic.txt
}

src_compile() {
	eant jar $(use_doc javadoc)
}

src_install() {
	java-pkg_newjar looks-${PV}.jar looks.jar

	dodoc RELEASE-NOTES.txt README.html
	use doc && java-pkg_dohtml -r build/docs/*
}
