# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagsoup/tagsoup-0.10.2.ebuild,v 1.3 2004/10/18 12:17:43 dholm Exp $

inherit java-pkg

DESCRIPTION="This is the home page of TagSoup, a SAX-compliant parser written in
Java that, instead of parsing well-formed or valid XML, parses HTML as it is
found in the wild: nasty and brutish, though quite often far from short."

HOMEPAGE="http://mercury.ccil.org/~cowan/XML/tagsoup/"
SRC_URI="http://mercury.ccil.org/~cowan/XML/tagsoup/${P}-src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} docs-api"
	ant ${antflags} || die "compile failed"
}

src_install() {
	mv dist/lib/${P}.jar dist/lib/${PN}.jar
	java-pkg_dojar dist/lib/${PN}.jar

	dodoc CHANGES LICENSE README TODO
	use doc && java-pkg_dohtml -r docs/*
}
