# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-codec/commons-codec-1.3.ebuild,v 1.3 2004/10/19 20:25:59 absinthe Exp $

inherit java-pkg

DESCRIPTION="Common Codecs provides implementations of common encoders and decoders such as Base64, Hex, various phonetic encodings, and URLs"
HOMEPAGE="http://jakarta.apache.org/commons/codec/"
SRC_URI="mirror://apache/jakarta/commons/codec/source/${PN}-${PV}-src.tar.gz"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	dev-java/avalon-logkit-bin
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="doc jikes junit"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp build.xml build.xml.b0rken
	sed -r "s_../LICENSE_LICENSE.txt_" \
		< build.xml.b0rken \
		> build.xml
	echo "junit.jar=`java-config -p junit`" > build.properties
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
	use junit && antflags="${antflags} test"
	echo ${antflags}
	ant ${antflags} jar || die "compile problem"
}

src_install() {
	java-pkg_dojar output/dist/${PN}.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r output/dist/docs/
}
