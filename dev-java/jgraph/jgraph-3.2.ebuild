# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgraph/jgraph-3.2.ebuild,v 1.1 2004/04/02 04:26:09 zx Exp $

inherit java-pkg

DESCRIPTION="Open-source graph component for Java"
SRC_URI="mirror://sourceforge/jgraph/${P}-java1.4-src.zip"
HOMEPAGE="http://www.jgraph.com"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant
		jikes? ( dev-java/jikes )"

RDEPEND=">=virtual/jdk-1.4"
LICENSE="jgraph"
SLOT="0"
KEYWORDS="~x86 ~sparc"

S=${WORKDIR}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar lib/${PN}.jar

	dodoc README LICENSE TODO WHATSNEW ChangeLog
	use doc && dohtml -r doc/
}
