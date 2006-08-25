# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xjavadoc/xjavadoc-1.1-r1.ebuild,v 1.1 2006/08/25 01:29:41 nichoj Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A standalone implementation of JavaDoc engine suited for XDoclet"
HOMEPAGE="http://xdoclet.sourceforge.net/xjavadoc/"
SRC_URI="mirror://sourceforge/xdoclet/${P}-src.tar.gz
	mirror://gentoo/${P}-supplement.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source"

COMMON_DEPEND="dev-java/commons-collections"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
# full ant needed for JJTree and JavaCC tasks, part of ant-nodeps.jar
DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	dev-java/javacc
	${COMMON_DEPEND}
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# remove the junit tests, would need xdoclet, causing circular dep
	epatch ${FILESDIR}/${P}-nojunit.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from commons-collections
	java-pkg_jar-from --build-only javacc
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use source && java-pkg_dosrc ${S}/src/*
}
