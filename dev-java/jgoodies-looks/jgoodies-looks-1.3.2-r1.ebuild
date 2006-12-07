# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-1.3.2-r1.ebuild,v 1.2 2006/12/07 07:36:06 opfer Exp $

inherit java-pkg-2 java-ant-2

MY_V=${PV//./_}
MY_PN="looks"
DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${MY_V}.zip"

LICENSE="BSD"
SLOT="1.3"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4.2
	dev-java/ant-core
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4.2"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A} || die "Unpack failed!"
	cd ${S}

	# Clean up the structure
	rm -rf *.jar examples/ src/

	# Unpack the sources into the proper structure
	mkdir ${S}/src && cd ${S}/src
	unzip ${S}/${MY_PN}-${PV}-src.zip &> /dev/null || die "Unpack Failed"

	# Copy the Gentoo'ized build.xml
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml
	cp ${FILESDIR}/plastic-${PV}.txt ${S}/plastic.txt
}

src_compile() {
	eant jar $(use_doc javadoc)
}

src_install() {
	java-pkg_newjar ${MY_PN}-${PV}.jar ${MY_PN}.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r build/docs/*
}
