# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-codec/commons-codec-1.3.ebuild,v 1.10 2007/02/13 19:26:49 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="Implementations of common encoders and decoders in Java."
HOMEPAGE="http://jakarta.apache.org/commons/codec/"
SRC_URI="mirror://apache/jakarta/commons/codec/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	~dev-java/avalon-logkit-1.2
	dev-java/log4j"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s_../LICENSE_LICENSE.txt_" build.xml  || die "sed failed"
	echo "conf.home=./src/conf" >> build.properties
	echo "source.home=./src/java" >> build.properties
	echo "build.home=./output" >> build.properties
	echo "dist.home=./output/dist" >> build.properties
	echo "test.home=./src/test" >> build.properties
	echo "final.name=commons-codec" >> build.properties
}

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} jar || die "compile problem"
}

src_install() {
	java-pkg_dojar output/dist/${PN}.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r output/dist/docs/
	use source && java-pkg_dosrc src/java/*
}
