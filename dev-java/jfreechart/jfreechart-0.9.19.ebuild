# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-0.9.19.ebuild,v 1.1 2004/07/30 11:42:29 axxo Exp $

inherit java-pkg

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		dev-java/jcommon
		=dev-java/servletapi-2.3*
		dev-java/gnu-jaxp
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	rm -f junit/*
	rm -f lib/*
	local antflags="compile -Djcommon.jar=$(java-config -p jcommon) -Dservlet.jar=$(java-config -p servletapi-2.3) -Dgnujaxp.jar=$(java-config -p gnu-jaxp)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar ${P}.jar
	dodoc README.txt CHANGELOG.txt
	use doc && dohtml -r javadoc/
}

