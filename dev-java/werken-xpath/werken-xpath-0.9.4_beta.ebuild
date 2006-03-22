# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/werken-xpath/werken-xpath-0.9.4_beta.ebuild,v 1.4 2006/03/22 06:29:58 wormo Exp $

inherit java-pkg eutils versionator

MY_PN=${PN//-/.}
MY_PV=$(replace_version_separator 3 '-')
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="W3C XPath-Rec implementation for DOM4J"
HOMEPAGE="http://sourceforge.net/projects/werken-xpath/"
SRC_URI="mirror://gentoo/${MY_P}-src.tar.gz"
# This tarball was acquired from jpackage's src rpm of the package by the same
# name

LICENSE="werken.xpath"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	dev-java/antlr
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	~dev-java/jdom-1.0_beta9"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Courtesy of JPackages :)
	epatch ${FILESDIR}/${P}-jpp-compile.patch
	epatch ${FILESDIR}/${P}-jpp-jdom.patch
	epatch ${FILESDIR}/${P}-jpp-tests.patch
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/lib
	# In here we have ant starter scripts
	rm -fr bin
	rm -f *.jar

	# compile target needs these
	java-pkg_jar-from jdom-1.0_beta9
	java-pkg_jar-from antlr
}

src_compile() {
	local antflags="package"

	# java.class.path is used by the prepare.grammars target that
	# runs antlr
	local jdomjars="$(java-pkg_getjars jdom-1.0_beta9)"
	local antlrjars="$(java-pkg_getjars antlr)"
	local antflags="${antflags} -Djava.class.path=${jdomjars}:${antlrjars}"

	use doc && antflags="${antflags} javadoc -Dbuild.javadocs=build/api"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/${MY_PN}.jar

	dodoc README TODO LIMITATIONS
	use doc && java-pkg_dohtml -r build/api
	use source && java-pkg_dosrc src/*
}
