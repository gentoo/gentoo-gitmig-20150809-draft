# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/webgraph/webgraph-1.4.1.ebuild,v 1.1 2005/04/15 13:12:42 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="WebGraph is a framework to study the web graph. It provides simple ways to manage very large graphs, exploiting modern compression techniques."
SRC_URI="http://webgraph.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://webgraph.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="1.4"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/jal-20031117
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/java-getopt-1.0*
	=dev-java/fastutil-4.4*
	=dev-java/colt-1.1*
	=dev-java/mg4j-0.9*"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	mkdir lib/ && cd lib/
	java-pkg_jar-from java-getopt-1
	java-pkg_jar-from fastutil-4.4
	java-pkg_jar-from colt colt.jar
	java-pkg_jar-from jal jal.jar
	java-pkg_jar-from mg4j-0.9
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	mv ${P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	if use doc; then
		dodoc CHANGES COPYING
		java-pkg_dohtml -r docs/*
	fi
	use source && java-pkg_dosrc java/it
}
