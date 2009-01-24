# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fec/fec-1.0.3.ebuild,v 1.1 2009/01/24 18:27:35 tommy Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Forword error correction libs"
HOMEPAGE="http://www.onionnetworks.com/developers/"
SRC_URI="http://www.onionnetworks.com/downloads/${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/log4j
	dev-java/concurrent-util"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	cp "${FILESDIR}"/build.xml src/ || die
	epatch "${FILESDIR}"/libfec8path.patch
	sed -i -e 's/build.compiler=jikes/#build.compiler=jikes/g' build.properties || die
	eant clean
	cd lib || die
	rm -rf * || die
	java-pkg_jar-from --build-only log4j
	java-pkg_jar-from --build-only concurrent-util concurrent.jar concurrent-jaxed.jar

	cd "${S}" || die
	unzip -q common-20020926.zip || die
	cd common-20020926 || die
	sed -i -e 's/build.compiler=jikes/#build.compiler=jikes/g' build.properties || die
	eant clean
	cd lib || die
	rm -f *jar || die
}

src_compile() {
	cd common-20020926 || die
	eant
	cp lib/onion-common.jar "${S}"/lib/ || die
	cd "${S}" || die
	eant
	cd src || die
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar src/${PN}.jar
	use doc && java-pkg_dojavadoc src/docs
	use source && java-pkg_dosrc src/com
}
