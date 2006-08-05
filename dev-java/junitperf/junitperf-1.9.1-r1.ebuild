# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junitperf/junitperf-1.9.1-r1.ebuild,v 1.1 2006/08/05 17:03:02 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Simple framework to write repeatable tests"
SRC_URI="http://www.clarkware.com/software/${P}.zip"
HOMEPAGE="http://www.clarkware.com/software/JUnitPerf.html"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc junit source"
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
	eant jar
}

src_test() {
	eant test
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README
	use doc && java-pkg_dohtml -r docs/api/*
	use source && java-pkg_dosrc src/app/*
}
