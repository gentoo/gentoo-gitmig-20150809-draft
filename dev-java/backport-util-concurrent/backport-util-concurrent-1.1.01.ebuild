# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/backport-util-concurrent/backport-util-concurrent-1.1.01.ebuild,v 1.1 2005/06/29 19:53:09 axxo Exp $

inherit java-pkg

MY_PV="1.1_01"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="This package is the backport of java.util.concurrent API, introduced in Java 5.0, to Java 1.4"
HOMEPAGE="http://www.mathcs.emory.edu/dcl/util/backport-util-concurrent/"
SRC_URI="http://www.mathcs.emory.edu/dcl/util/${PN}/dist/${MY_P}/${MY_P}-src.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes doc"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	dev-java/junit
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}-src"

src_unpack() {
	unpack ${A}
	cd ${S}/external
	rm -f *.jar
	java-pkg_jar-from junit
}

src_compile() {
	local antflags="javacompile archive"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r doc/api
	java-pkg_dohtml README.html
}
