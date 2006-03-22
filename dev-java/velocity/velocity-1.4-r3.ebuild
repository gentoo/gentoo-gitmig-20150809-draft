# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/velocity/velocity-1.4-r3.ebuild,v 1.4 2006/03/22 06:32:55 wormo Exp $

inherit java-pkg eutils

DESCRIPTION="A Java-based template engine that allows easy creation/rendering of documents that format and present data."
HOMEPAGE="http://jakarta.apache.org/velocity/"
SRC_URI="mirror://apache/jakarta/${PN}/binaries/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.3.1
	dev-java/ant-core
	dev-java/antlr
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.3.1
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
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-versioned_jar.patch

	cd ${S}/build/lib
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
}

src_compile () {
	cd ${S}/build
	local antflags="jar jar-core jar-util jar-servlet"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"

	ant ${antflags} || die "Ant failed"
}


src_install () {
	java-pkg_dojar bin/*.jar

	dodoc NOTICE README.txt
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
