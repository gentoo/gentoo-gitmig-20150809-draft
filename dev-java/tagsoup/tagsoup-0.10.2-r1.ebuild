# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagsoup/tagsoup-0.10.2-r1.ebuild,v 1.6 2007/04/04 13:29:39 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A SAX-compliant parser written in Java."

HOMEPAGE="http://mercury.ccil.org/~cowan/XML/tagsoup/"
SRC_URI="http://mercury.ccil.org/~cowan/XML/tagsoup/${P}-src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

# Needs the xslt task so full ant here
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	|| ( dev-java/ant-trax dev-java/ant-tasks )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	ANT_TASKS="ant-trax" eant $(use_doc docs-api) dist
}

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	dodoc CHANGES README TODO || die
	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/{java,templates}/*
}
