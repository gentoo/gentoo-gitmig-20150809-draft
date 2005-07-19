# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junitperf/junitperf-1.9.1.ebuild,v 1.8 2005/07/19 00:15:43 axxo Exp $

inherit java-pkg

DESCRIPTION="Simple framework to write repeatable tests"
SRC_URI="http://www.clarkware.com/software/${P}.zip"
HOMEPAGE="http://www.clarkware.com/software/JUnitPerf.html"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="doc jikes junit source"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/junit-3.8.1
	dev-java/ant
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README
	use doc && java-pkg_dohtml -r docs/api/*
	use source && java-pkg_dosrc src/app/*
}
