# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qdox/qdox-20050104.ebuild,v 1.2 2005/03/24 03:46:39 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Parser for extracting class/interface/method definitions from source files with JavaDoc tags."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://qdox.codehaus.org"
LICENSE="Apache-1.1"
SLOT="1.6" # it's the 1.6 codebase
KEYWORDS="~x86 ~amd64"
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
	dodoc LICENSE.txt README.txt

	use doc	&& java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/java/*
}
