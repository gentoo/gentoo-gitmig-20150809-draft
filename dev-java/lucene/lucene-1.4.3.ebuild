# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.4.3.ebuild,v 1.3 2005/07/15 21:11:50 axxo Exp $

inherit java-pkg

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="mirror://apache/jakarta/lucene/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc jikes junit source"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/ant-1.5
	jikes? ( dev-java/jikes )
	junit? ( dev-java/junit )"
RDEPEND=">=virtual/jdk-1.2"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from junit
}


src_compile() {
	local antflags="jar-core"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	dodoc CHANGES.txt README.txt
	java-pkg_newjar build/lucene-1.5-rc1-dev.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/org
}
