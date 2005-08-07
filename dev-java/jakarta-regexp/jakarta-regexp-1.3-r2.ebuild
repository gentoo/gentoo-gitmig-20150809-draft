# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-regexp/jakarta-regexp-1.3-r2.ebuild,v 1.3 2005/08/07 12:42:13 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"
SLOT="1.3"
IUSE="doc jikes source"
LICENSE="Apache-1.1"
KEYWORDS="x86 ppc sparc amd64 ppc64"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar
	mkdir lib
	sed -i 's:./jakarta-site2::' build.xml || die "sed failed"
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	cd ${S}/build
	java-pkg_newjar ${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/api/*
	use source && java-pkg_dosrc ${S}/src/java/*
}
