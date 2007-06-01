# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-0.9.21-r2.ebuild,v 1.4 2007/06/01 17:16:22 nixnut Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc source"

COMMON_DEP="=dev-java/jcommon-0.9*
	=dev-java/servletapi-2.3*"

RDEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -v lib/* *.jar || die
}

src_compile() {
	local antflags="compile -Djcommon.jar=$(java-pkg_getjars jcommon) \
		-Dservlet.jar=$(java-pkg_getjar servletapi-2.3 servlet.jar)"
	eant -f ant/build.xml ${antflags} $(use_doc)
}

src_install() {
	java-pkg_newjar ${P}.jar

	dodoc README.txt CHANGELOG.txt || die
	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc source/*
}
