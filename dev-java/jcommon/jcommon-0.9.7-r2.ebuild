# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-0.9.7-r2.ebuild,v 1.1 2006/09/11 12:31:50 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/jfreechart/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
		dev-java/junit"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {

	unpack ${A}
	cd ${S}
	rm *.jar

}

src_compile() {

	local antflags="compile"
	use doc && antflags="${antflags} javadoc"
	eant -f ant/build.xml ${antflags} || die "compile failed"

}

src_install() {

	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.txt
	use doc && java-pkg_dohtml -r javadoc
	use source && java-pkg_dosrc source/*

}
