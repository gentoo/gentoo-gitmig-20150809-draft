# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mg4j/mg4j-0.9.1.ebuild,v 1.9 2007/07/11 19:58:37 mr_bones_ Exp $

inherit eutils java-pkg

DESCRIPTION="A free Java implementation of inverted-index compression technique."
SRC_URI="http://mg4j.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://mg4j.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="0.9"
KEYWORDS="x86 ~ppc amd64"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/fastutil-4.3*
	>=dev-java/jal-20031117
	dev-java/colt
	=dev-java/java-getopt-1.0*
	=dev-java/libreadline-java-0.8*"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/javacc-3
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/mg4j-build.patch

	mkdir lib/ && cd lib/
	java-pkg_jar-from colt
	java-pkg_jar-from fastutil-4.3
	java-pkg_jar-from jal
	java-pkg_jar-from libreadline-java
	java-pkg_jar-from java-getopt-1
}

src_compile () {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc java/it
}
