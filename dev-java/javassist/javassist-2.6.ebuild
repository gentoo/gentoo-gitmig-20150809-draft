# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javassist/javassist-2.6.ebuild,v 1.4 2007/01/31 12:44:04 drizzt Exp $

inherit java-pkg

DESCRIPTION="Javassist makes Java bytecode manipulation simple."
SRC_URI="mirror://sourceforge/jboss/${P}.zip"
HOMEPAGE="http://www.csg.is.titech.ac.jp/~chiba/javassist/"

LICENSE="MPL-1.1"
SLOT="2"
KEYWORDS="amd64 ppc x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		>=dev-java/ant-core-1.5
		jikes? ( dev-java/jikes )
		source? ( app-arch/zip )"
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -rf work
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dohtml *.html
	use doc && java-pkg_dohtml -r html/*
	use source && java-pkg_dosrc src/main/javassist
}
