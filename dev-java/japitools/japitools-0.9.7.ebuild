# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/japitools/japitools-0.9.7.ebuild,v 1.1 2006/11/19 11:03:03 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java API compatibility testing tools"
HOMEPAGE="http://sab39.netreach.com/japi/"

SRC_URI="http://www.kaffe.org/~stuart/japi/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

IUSE="doc test source"

DEPEND="dev-java/ant-core
		>=virtual/jdk-1.4
		test? ( dev-java/junit dev-java/ant-tasks )
		source? ( app-arch/zip )"

RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}

	cd ${S}/bin
	rm japize.bat
	sed -e "s:../share/java:../share/${PN}/lib:" -i * \
		|| die "Failed to correct the location of the jar file in perl scripts."
}

src_compile() {
	eant jar
}

src_test() {
	eant test
}
src_install() {
	java-pkg_dojar share/java/*.jar
	dobin bin/*

	if use doc; then
		cp -r design "${T}"
		dohtml "${T}"/design/{*.css,*.html}
		rm "${T}"/design/{*.css,*.html}
		dodoc "${T}"/design/*
	fi

	use source && java-pkg_dosrc src/*
}
