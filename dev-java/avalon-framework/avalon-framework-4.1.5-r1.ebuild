# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-framework/avalon-framework-4.1.5-r1.ebuild,v 1.4 2006/10/17 03:35:12 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Avalon Framework"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/avalon-framework/source/${P}.src.tar.gz"

LICENSE="Apache-2.0"
SLOT="4.1"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc source"

COMMON_DEP="
	=dev-java/avalon-logkit-2*
	>=dev-java/log4j-1.2.9"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	source? ( app-arch/zip )
	${COMMON_DEP}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/build.xml ./build.xml || die "ANT update failure!"
	local libs="log4j,avalon-logkit-2.0"
	echo "classpath=$(java-pkg_getjars ${libs})" > build.properties
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar ${S}/dist/avalon-framework.jar

	use doc && java-pkg_dohtml -r ${S}/target/docs/*
	use source && java-pkg_dosrc impl/src/java/*
}
