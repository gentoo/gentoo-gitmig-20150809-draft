# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aspectwerkz/aspectwerkz-2.0_rc2.ebuild,v 1.8 2007/02/11 16:44:55 nixnut Exp $

inherit java-pkg eutils

DESCRIPTION="AspectWerkz is a dynamic, lightweight and high-performant AOP/AOSD framework for Java."
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${P/_rc/.RC}.zip"
HOMEPAGE="http://aspectwerkz.codehaus.org"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="amd64 ppc x86"
RDEPEND=">=virtual/jre-1.4
	=dev-java/asm-1.5*
	dev-java/bcel
	dev-java/concurrent-util
	=dev-java/dom4j-1*
	=dev-java/javassist-2*
	dev-java/jrexx
	>=dev-java/junitperf-1.9.1
	dev-java/trove
	~dev-java/qdox-20050104"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.5
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
IUSE="jikes source"

S=${WORKDIR}/aw_2_0_2

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	find . -name '*.jar' -exec rm {} \; || die
	cd ${S}/lib
	#rm *.jar
	java-pkg_jar-from asm-1.5
	java-pkg_jar-from bcel
	java-pkg_jar-from concurrent-util
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from javassist-2
	java-pkg_jar-from jrexx
	java-pkg_jar-from junitperf
	java-pkg_jar-from trove
	java-pkg_jar-from qdox-1.6
}

src_compile() {
	local antflags="dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/${PN}*.jar

	use source && java-pkg_dosrc src/*
}
