# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjgraph/openjgraph-0.9.2-r1.ebuild,v 1.2 2004/11/03 11:36:06 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Open-source graph library for Java"
SRC_URI="mirror://sourceforge/openjgraph/${P}.zip"
HOMEPAGE="http://openjgraph.sf.net"
IUSE=""
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/log4j
	dev-java/junit
	=dev-java/xerces-1.3*
	>=dev-java/ant-1.6"

RDEPEND=">=virtual/jdk-1.4"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

S=${WORKDIR}/${P//./_}

src_unpack() {
	unpack ${A}
	cd ${S}/lib/
	rm -f ant.jar jakarta-ant-1.4.1-optional.jar junit.jar log4j-core.jar jaxp.jar crimson.jar
	java-pkg_jar-from log4j
	java-pkg_jar-from xerces-1.3
	java-pkg_jar-from junit
}

src_compile() {
	./compileall.sh || die "compile failed"
}

src_install () {
	java-pkg_dojar dist/${PN}.jar

	insinto /usr/share/${PN}/examples
	doins examples/*

	dodoc README
	dohtml *.html
}
