# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junitperf/junitperf-1.9.1.ebuild,v 1.1 2004/11/14 14:05:51 axxo Exp $

inherit java-pkg

DESCRIPTION="Simple framework to write repeatable tests"
SRC_URI="http://www.clarkware.com/software/${P}.zip"
HOMEPAGE="http://www.clarkware.com/software/JUnitPerf.html"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes junit"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	>=dev-java/junit-3.8.1
	>=app-arch/unzip-5.50-r1
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc LICENSE README
	use doc && java-pkg_dohtml -r docs/api/*
}
