# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.3.ebuild,v 1.2 2004/03/23 02:58:31 zx Exp $

inherit java-pkg

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="mirror://apache/jakarta/lucene/source/${P}-final-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.2
		>=dev-java/ant-1.5
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.2"

S="${WORKDIR}/${P}-final"

src_compile() {
	local antflags="jar-core"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	dodoc CHANGES.txt README.txt
	cd build
	mv lucene-1.4-rc1-dev.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	use doc && dohtml -r docs/*
}
