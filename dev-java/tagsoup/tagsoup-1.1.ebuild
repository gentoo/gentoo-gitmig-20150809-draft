# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagsoup/tagsoup-1.1.ebuild,v 1.1 2007/04/04 13:56:20 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A SAX-compliant parser written in Java."

HOMEPAGE="http://mercury.ccil.org/~cowan/XML/tagsoup/"
SRC_URI="http://mercury.ccil.org/~cowan/XML/tagsoup/${P}-src.zip"
LICENSE="|| ( AFL-3.0 GPL-2 )"
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
	java-pkg_dolauncher ${PN} --jar ${PN}.jar

	doman ${PN}.1 || die
	dodoc CHANGES README TODO || die

	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/{java,templates}/*
}
