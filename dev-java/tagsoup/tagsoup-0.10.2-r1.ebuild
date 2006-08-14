# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagsoup/tagsoup-0.10.2-r1.ebuild,v 1.1 2006/08/14 20:11:22 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="This is the home page of TagSoup, a SAX-compliant parser written in Java that, instead of parsing well-formed or valid XML, parses HTML as it is found in the wild: nasty and brutish, though quite often far from short."

HOMEPAGE="http://mercury.ccil.org/~cowan/XML/tagsoup/"
SRC_URI="http://mercury.ccil.org/~cowan/XML/tagsoup/${P}-src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc source"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} docs-api"
	eant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	dodoc CHANGES README TODO
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
