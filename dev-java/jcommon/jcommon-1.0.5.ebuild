# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-1.0.5.ebuild,v 1.2 2007/02/03 10:40:56 nixnut Exp $

inherit java-pkg-2 java-ant-2 versionator

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org"

SRC_URI="mirror://sourceforge/jfreechart/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="debug doc source"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
		dev-java/junit"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {

	unpack ${A}
	cd ${S}
	rm *.jar ${S}/lib/*.jar

}

src_compile() {

	local antflags="compile -Djcommon-jar-file=${PN}.jar"

	#jcommon builds a debug version by default
	if ! use debug; then
		antflags="${antflags} -Dbuild.debug=false -Dbuild.optimize=true"
	fi

	use doc && antflags="${antflags} javadoc"
	eant -f ant/build.xml ${antflags} || die "compile failed"

}

src_install() {

	java-pkg_dojar ${PN}.jar
	dodoc README.txt
	use doc && java-pkg_dohtml -r javadoc
	use source && java-pkg_dosrc source/*

}
