# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-0.9.19.ebuild,v 1.6 2004/11/06 09:58:30 axxo Exp $

inherit java-pkg

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		dev-java/jcommon
		=dev-java/servletapi-2.3*
		dev-java/gnu-jaxp
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f junit/*
	rm -f lib/*
}

src_compile() {
	local antflags="compile -Djcommon.jar=$(java-config -p jcommon) -Dservlet.jar=$(java-config -p servletapi-2.3) -Dgnujaxp.jar=$(java-config -p gnu-jaxp)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar ${P}.jar
	dodoc README.txt CHANGELOG.txt
	use doc && java-pkg_dohtml -r javadoc/
}

