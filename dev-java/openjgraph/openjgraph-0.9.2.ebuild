# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjgraph/openjgraph-0.9.2.ebuild,v 1.7 2005/07/15 20:15:04 axxo Exp $

inherit java-pkg

DESCRIPTION="Open-source graph library for Java"
SRC_URI="mirror://sourceforge/openjgraph/${P}.zip"
HOMEPAGE="http://openjgraph.sf.net"
IUSE=""
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"

S=${WORKDIR}/${P//./_}

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
