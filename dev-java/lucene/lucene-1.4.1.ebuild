# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.4.1.ebuild,v 1.4 2004/10/26 12:35:56 axxo Exp $

inherit java-pkg

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="http://cvs.apache.org/dist/jakarta/lucene/v1.4.1/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="jikes doc junit"
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
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compilation failed"

	if use junit; then
		ant test || die "Junit test failed"
	fi
}

src_install() {
	dodoc CHANGES.txt README.txt
	cd build
	mv lucene-1.5-rc1-dev.jar ${PN}.jar || die "mv failed"
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/*
}
