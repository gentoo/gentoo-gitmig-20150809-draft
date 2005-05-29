# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-codec/commons-codec-1.3.ebuild,v 1.6 2005/05/29 15:37:52 corsair Exp $

inherit java-pkg

DESCRIPTION="Common Codecs provides implementations of common encoders and decoders such as Base64, Hex, various phonetic encodings, and URLs"
HOMEPAGE="http://jakarta.apache.org/commons/codec/"
SRC_URI="mirror://apache/jakarta/commons/codec/source/${PN}-${PV}-src.tar.gz"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	dev-java/avalon-logkit-bin
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="doc jikes"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp build.xml build.xml.b0rken
	sed -r "s_../LICENSE_LICENSE.txt_" \
		< build.xml.b0rken \
		> build.xml
	echo "conf.home=./src/conf" >> build.properties
	echo "source.home=./src/java" >> build.properties
	echo "build.home=./output" >> build.properties
	echo "dist.home=./output/dist" >> build.properties
	echo "test.home=./src/test" >> build.properties
	echo "final.name=commons-codec" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	echo ${antflags}
	ant ${antflags} jar || die "compile problem"
}

src_install() {
	java-pkg_dojar output/dist/${PN}.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r output/dist/docs/
}
