# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qdox/qdox-20050104.ebuild,v 1.7 2007/11/02 03:22:07 wltjr Exp $

inherit java-pkg

DESCRIPTION="Parser for extracting class/interface/method definitions from source files with JavaDoc tags."
HOMEPAGE="http://qdox.codehaus.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="1.6" # it's the 1.6 codebase
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	dodoc README.txt

	use doc	&& java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/java/*
}
