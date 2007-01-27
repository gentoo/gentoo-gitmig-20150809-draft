# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-0.9.21-r1.ebuild,v 1.2 2007/01/27 23:03:57 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
RDEPEND=">=virtual/jdk-1.4
	=dev-java/jcommon-0.9*
	=dev-java/servletapi-2.3*
	dev-java/gnu-jaxp"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v lib/* *.jar
}

src_compile() {
	local antflags="compile -Djcommon.jar=$(java-pkg_getjars jcommon) \
		-Dservlet.jar=$(java-pkg_getjar servletapi-2.3 servlet.jar) \
		-Dgnujaxp.jar=$(java-pkg_getjars gnu-jaxp)"
	eant -f ant/build.xml ${antflags} $(use_doc) || die "compile failed"
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.txt CHANGELOG.txt || die
	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc source/*
}
