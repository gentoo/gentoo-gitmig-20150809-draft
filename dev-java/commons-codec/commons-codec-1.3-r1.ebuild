# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-codec/commons-codec-1.3-r1.ebuild,v 1.12 2008/03/22 02:24:52 betelgeuse Exp $

EAPI=1
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Implementations of common encoders and decoders in Java."
HOMEPAGE="http://jakarta.apache.org/commons/codec/"
SRC_URI="mirror://apache/jakarta/commons/codec/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.3
	=dev-java/avalon-logkit-1.2*
	dev-java/log4j"

DEPEND=">=virtual/jdk-1.3
	test? ( dev-java/ant-junit:0 )
	${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/1.3-tests-fix.patch"
	sed -i "s_../LICENSE_LICENSE.txt_" build.xml  || die "sed failed"
	echo "conf.home=./src/conf" >> build.properties
	echo "source.home=./src/java" >> build.properties
	echo "build.home=./output" >> build.properties
	echo "dist.home=./output/dist" >> build.properties
	echo "test.home=./src/test" >> build.properties
	echo "final.name=commons-codec" >> build.properties
	java-ant_xml-rewrite -f build.xml -c -e javac -a encoding -v ISO8859-1
}

src_install() {
	java-pkg_dojar output/dist/${PN}.jar

	dodoc RELEASE-NOTES.txt || die
	use doc && java-pkg_dojavadoc output/dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
