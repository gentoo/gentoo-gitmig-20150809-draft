# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/werken-xpath/werken-xpath-0.9.4_beta-r1.ebuild,v 1.7 2007/06/18 17:33:54 flameeyes Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils versionator

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
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

COMMON_DEP="
	~dev-java/jdom-1.0_beta9
	dev-java/antlr"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

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

	eant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/${MY_PN}.jar

	dodoc README TODO LIMITATIONS || die
	use doc && java-pkg_dojavadoc build/api
	use source && java-pkg_dosrc src/*
}
