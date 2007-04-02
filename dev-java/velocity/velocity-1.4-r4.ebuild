# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/velocity/velocity-1.4-r4.ebuild,v 1.5 2007/04/02 21:11:49 betelgeuse Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="A Java-based template engine that allows easy creation/rendering of documents that format and present data."
HOMEPAGE="http://velocity.apache.org"
SRC_URI="mirror://apache/jakarta/${PN}/binaries/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc source"

DEPEND="
	!doc? ( >=virtual/jdk-1.4 )
	doc? ( || ( =virtual/jdk-1.4* =virtual/jdk-1.5* ) )
	dev-java/ant-core
	dev-java/antlr
	dev-java/junit
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.4
	dev-java/bcel
	dev-java/commons-collections
	=dev-java/jdom-1.0_beta9*
	dev-java/log4j
	=dev-java/avalon-logkit-1.2*
	=dev-java/jakarta-oro-2.0*
	=dev-java/servletapi-2.2*
	dev-java/werken-xpath"

pkg_setup() {
	if ! built_with_use dev-java/log4j javamail; then
		eerror "Velocity needs javamail specific classes built into"
		eerror "log4j. Please re-emerge log4j with the javamail use"
		eerror "flag turned on."
		die "log4j not built with the javamail use flag"
	fi
	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${P}-versioned_jar.patch

	cd "${S}/build/lib"
	rm *.jar
	java-pkg_jar-from antlr
	java-pkg_jar-from bcel
	java-pkg_jar-from commons-collections
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from jdom-1.0_beta9
	java-pkg_jar-from log4j
	java-pkg_jar-from avalon-logkit-1.2
	java-pkg_jar-from servletapi-2.2
	java-pkg_jar-from werken-xpath
	java-pkg_jar-from junit
	java-pkg_jar-from ant-core
}

src_compile () {
	cd "${S}/build"
	local antflags="jar jar-core jar-util jar-servlet"
	eant ${antflags} $(use_doc javadocs) || die "Ant failed"
}


src_install () {
	java-pkg_dojar bin/*.jar

	dodoc NOTICE README.txt || die
	#has other stuff besides api too
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
