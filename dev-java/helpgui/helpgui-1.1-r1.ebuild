# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/helpgui/helpgui-1.1-r1.ebuild,v 1.1 2007/01/28 17:09:22 wltjr Exp $

inherit java-pkg-2

DESCRIPTION="HelpGUI is a simple library which develop a help viewer component."
HOMEPAGE="http://helpgui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	jar xf ${DISTDIR}/${A} || die
}

src_compile() {
	eant helpgui_jar $(use_doc javadocs)
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc README
	use doc && java-pkg_dohtml -r build/docs/
	use source && java-pkg_dosrc src/*
}
