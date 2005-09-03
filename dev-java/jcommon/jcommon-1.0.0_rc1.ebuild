# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-1.0.0_rc1.ebuild,v 1.1 2005/09/03 21:38:23 betelgeuse Exp $

inherit java-pkg versionator

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org"
MY_P=${PN}-$(replace_version_separator 3 -)
SRC_URI="mirror://sourceforge/jfreechart/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		dev-java/junit
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/${MY_P}

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
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc README.txt
	use doc && java-pkg_dohtml -r javadoc
}
