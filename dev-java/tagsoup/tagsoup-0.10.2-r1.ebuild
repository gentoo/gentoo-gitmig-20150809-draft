# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagsoup/tagsoup-0.10.2-r1.ebuild,v 1.4 2006/12/20 21:11:53 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A SAX-compliant parser written in Java."

HOMEPAGE="http://mercury.ccil.org/~cowan/XML/tagsoup/"
SRC_URI="http://mercury.ccil.org/~cowan/XML/tagsoup/${P}-src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc source"

# Needs the xslt task so full ant here
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	eant $(use_doc docs-api) dist
}

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	dodoc CHANGES README TODO
	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/{java,templates}/*
}
