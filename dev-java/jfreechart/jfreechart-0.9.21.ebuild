# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-0.9.21.ebuild,v 1.5 2005/07/12 19:49:44 axxo Exp $

inherit java-pkg

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc jikes"
RDEPEND=">=virtual/jdk-1.3
	dev-java/jcommon
	=dev-java/servletapi-2.3*
	dev-java/gnu-jaxp"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f lib/* *.jar
}

src_compile() {
	local antflags="compile -Djcommon.jar=$(java-pkg_getjars jcommon) \
		-Dservlet.jar=$(java-pkg_getjar servletapi-2.3 servlet.jar) \
		-Dgnujaxp.jar=$(java-pkg_getjars gnu-jaxp)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.txt CHANGELOG.txt
	use doc && java-pkg_dohtml -r javadoc/
}

