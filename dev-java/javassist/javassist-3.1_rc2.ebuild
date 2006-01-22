# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javassist/javassist-3.1_rc2.ebuild,v 1.1 2006/01/22 04:59:08 nichoj Exp $

inherit java-pkg

MY_PV=${PV/_rc/RC}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Javassist makes Java bytecode manipulation simple."
SRC_URI="mirror://sourceforge/jboss/${MY_P}.zip"
HOMEPAGE="http://www.csg.is.titech.ac.jp/~chiba/javassist/"

LICENSE="MPL-1.1"
SLOT="3.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		>=dev-java/ant-core-1.5
		jikes? ( dev-java/jikes )
		source? ( app-arch/zip )"
S="${WORKDIR}/${MY_P}"

src_compile() {
	local antflags="clean jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "failed to build"
	mv html api
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dohtml Readme.html
	use doc && java-pkg_dohtml -r api
	use source && java-pkg_dosrc src/main/javassist
}
