# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javassist/javassist-2.6.ebuild,v 1.1 2004/10/30 20:27:30 axxo Exp $

inherit java-pkg

DESCRIPTION="Javassist makes Java bytecode manipulation simple."
SRC_URI="mirror://sourceforge/jboss/${P}.zip"
HOMEPAGE="http://www.csg.is.titech.ac.jp/~chiba/javassist/"
LICENSE="MPL-1.1"
SLOT="2"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		>=dev-java/ant-core-1.5	"
IUSE="doc jikes"
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
	dodoc *.html
	use doc && java-pkg_dohtml -r html/*
}
