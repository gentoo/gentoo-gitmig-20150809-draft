# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/webgraph/webgraph-1.4.1.ebuild,v 1.5 2007/04/02 07:26:15 opfer Exp $

inherit eutils java-pkg

DESCRIPTION="WebGraph is a framework to study the web graph."
SRC_URI="http://webgraph.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://webgraph.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="1.4"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/java-getopt-1.0*
	=dev-java/fastutil-4.4*
	=dev-java/colt-1*
	>=dev-java/jal-20031117
	=dev-java/mg4j-0.9*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

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
	java-pkg_newjar ${P}.jar ${PN}.jar

	if use doc; then
		dodoc CHANGES
		java-pkg_dohtml -r docs/*
	fi
	use source && java-pkg_dosrc java/it
}
