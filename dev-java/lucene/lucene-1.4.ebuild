# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene/lucene-1.4.ebuild,v 1.3 2004/10/22 11:28:24 absinthe Exp $

inherit java-pkg

DESCRIPTION="High-performance, full-featured text search engine written entirely in Java"
HOMEPAGE="http://jakarta.apache.org/lucene"
SRC_URI="mirror://apache/jakarta/lucene/source/${P}-final-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.2
		>=dev-java/ant-1.5
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.2"

S="${WORKDIR}/${P}-final"

src_compile() {
	local antflags="jar-core"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	dodoc CHANGES.txt README.txt
	cd build
	mv lucene-1.5-rc1-dev.jar ${PN}.jar || die "mv failed"
	java-pkg_dojar ${PN}.jar || die "dojar failed"
	use doc && java-pkg_dohtml -r docs/*
}
