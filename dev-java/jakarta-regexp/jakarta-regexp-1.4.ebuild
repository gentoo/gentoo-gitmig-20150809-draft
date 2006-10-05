# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-regexp/jakarta-regexp-1.4.ebuild,v 1.4 2006/10/05 17:20:05 gustavoz Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"
SLOT="1.4"
IUSE="doc source"
LICENSE="Apache-1.1"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar
	mkdir lib
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	eant ${antflags} || die "compile problem"
}

src_install() {
	cd ${S}/build
	java-pkg_newjar ${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/api/*
	use source && java-pkg_dosrc ${S}/src/java/*
}
