# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjgraph/openjgraph-0.9.2-r1.ebuild,v 1.5 2006/10/05 18:07:22 gustavoz Exp $

inherit java-pkg eutils

DESCRIPTION="Open-source graph library for Java"
SRC_URI="mirror://sourceforge/openjgraph/${P}.zip"
HOMEPAGE="http://openjgraph.sf.net"
IUSE=""
RDEPEND=">=virtual/jre-1.4
	dev-java/log4j
	=dev-java/xerces-1.3*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/unzip
	dev-java/junit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

S=${WORKDIR}/${P//./_}

src_unpack() {
	unpack ${A}
	cd ${S}/lib/
	rm -f *.jar
	java-pkg_jar-from log4j
	java-pkg_jar-from xerces-1.3
	java-pkg_jar-from junit
}

src_compile() {
	./compileall.sh || die "compile failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	insinto /usr/share/${PN}/examples
	doins examples/*

	dodoc README
	dohtml *.html
}
