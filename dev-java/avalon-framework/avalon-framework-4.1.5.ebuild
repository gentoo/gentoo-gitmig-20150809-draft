# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-framework/avalon-framework-4.1.5.ebuild,v 1.3 2005/03/26 03:47:36 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Avalon Framework"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/avalon-framework/source/${PF}.src.tar.gz"
KEYWORDS="~amd64 ~x86 ~sparc"
LICENSE="Apache-2.0"
SLOT="4.1"

IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/log4j-1.2.9
		>=dev-java/ant-core-1.5
		=dev-java/avalon-logkit-2*
		jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/build.xml ./build.xml || die "ANT update failure!"
	local libs="log4j,avalon-logkit-2.0"
	echo "classpath=`java-config -p ${libs}`" > build.properties
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed!"
}

src_install() {
	java-pkg_dojar ${S}/dist/avalon-framework.jar
	dodoc LICENSE.txt
	use doc && java-pkg_dohtml -r ${S}/target/docs/*
}
