# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/struts-legacy/struts-legacy-1.0-r1.ebuild,v 1.7 2004/10/17 07:32:04 absinthe Exp $

inherit java-pkg

DESCRIPTION="Jakarta Struts Legacy Library"
SRC_URI="mirror://apache/jakarta/struts/struts-legacy/${P}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/struts/"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	jikes? ( dev-java/jikes )"
RDEPEND="|| (
		>=virtual/jdk-1.4
		( >=virtual/jdk-1.3 >=dev-java/jdbc2-stdext-2.0 )
	)
	dev-java/commons-logging"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

S=${WORKDIR}/${P}-src

src_compile() {
	sed -i 's:compile,docs:compile:' build.xml || die "sed failed"
	echo "commons-logging.jar=`java-config -p commons-logging | sed 's/.*://'`" > build.properties
	echo "jdbc20ext.jar=`java-config -p jdbc2-stdext`" >> build.properties
	echo "jdk.version=1.4" >> build.properties

	local antflags="dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar dist/*.jar
	dodoc STATUS.txt
	use doc && java-pkg_dohtml -r dist/docs/
}
