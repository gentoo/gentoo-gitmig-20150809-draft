# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-1.0.0_rc1.ebuild,v 1.1 2005/09/03 22:46:02 betelgeuse Exp $

inherit java-pkg versionator

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
MY_P=${PN}-$(replace_version_separator 3 -)
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes"
RDEPEND=">=virtual/jdk-1.3
	=dev-java/jcommon-1.0*
	=dev-java/servletapi-2.3*
	dev-java/gnu-jaxp"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f lib/* *.jar
}

src_compile() {
	local antflags="compile -Djcommon.jar=$(java-pkg_getjars jcommon-1.0) \
		-Dservlet.jar=$(java-pkg_getjar servletapi-2.3 servlet.jar) \
		-Dgnujaxp.jar=$(java-pkg_getjars gnu-jaxp)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar ${MY_P}.jar ${PN}.jar
	dodoc README.txt CHANGELOG.txt
	use doc && java-pkg_dohtml -r javadoc/
}

