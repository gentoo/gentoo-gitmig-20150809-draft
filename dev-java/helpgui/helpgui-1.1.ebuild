# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/helpgui/helpgui-1.1.ebuild,v 1.2 2005/07/16 12:19:34 axxo Exp $

inherit java-pkg

DESCRIPTION="HelpGUI is a simple library which develop a help viewer component."
HOMEPAGE="http://helpgui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	jar xf ${DISTDIR}/${A} || die
}

src_compile() {
	local antflags="helpgui_jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc README
	use doc && java-pkg_dohtml -r build/docs/
	use source && java-pkg_dosrc src/*
}
