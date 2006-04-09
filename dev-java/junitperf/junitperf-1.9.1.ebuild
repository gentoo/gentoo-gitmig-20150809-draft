# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junitperf/junitperf-1.9.1.ebuild,v 1.10 2006/04/09 15:23:37 nichoj Exp $

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
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	junit? ( dev-java/ant-tasks )
	source? ( app-arch/zip )"

RDEPEND=">=virtual/jre-1.3
	dev-java/junit"

src_unpack () {
	unpack ${A}
	rm ${S}/lib/*.jar
}

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
