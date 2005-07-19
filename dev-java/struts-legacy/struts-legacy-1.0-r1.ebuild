# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/struts-legacy/struts-legacy-1.0-r1.ebuild,v 1.13 2005/07/19 18:34:36 axxo Exp $

inherit java-pkg

DESCRIPTION="Jakarta Struts Legacy Library"
SRC_URI="mirror://apache/jakarta/struts/struts-legacy/${P}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/struts/"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.4
		dev-java/commons-logging"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant
		${RDEPEND}
		jikes? ( dev-java/jikes )"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"

S=${WORKDIR}/${P}-src

src_compile() {
	sed -i 's:compile,docs:compile:' build.xml || die "sed failed"
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" > build.properties
	echo "jdk.version=1.4" >> build.properties

	local antflags="dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc STATUS.txt
	use doc && java-pkg_dohtml -r dist/docs/
}
