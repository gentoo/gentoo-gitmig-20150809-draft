# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/glazedlists/glazedlists-1.5.0.ebuild,v 1.3 2006/12/29 23:46:34 opfer Exp $

# java-ant-2 not needed - build.xml sets source/target properly
inherit java-pkg-2 eutils

DESCRIPTION="A toolkit for list transformations"
HOMEPAGE="http://publicobject.com/${PN}/"
# there's also 1.5 source available, potential java5 useflag
SRC_URI="https://${PN}.dev.java.net/files/documents/1073/26115/${P}-source_java14.zip"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="x86"
IUSE="doc source test"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	test? (
		dev-java/junit
		dev-java/ant
	)
	!test? ( dev-java/ant-core )
	app-arch/unzip"
S="${WORKDIR}"

# tests need X otherwise fail
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable autodownloading of dependencies
	# sort out test targets
	epatch "${FILESDIR}/${P}-build.xml.patch"

	if use test; then
		# make testcases -source 1.4 friendly
		epatch "${FILESDIR}/${P}-tests.patch"
		cd extensions
		java-pkg_jar-from --build-only junit junit.jar
	fi
}

src_compile() {
	eant jar $(use_doc docs)
}

src_test() {
	eant test
}

src_install() {
	java-pkg_newjar "${PN}_java14.jar"
	if use doc; then
		dohtml readme.html
		java-pkg_dohtml -r docs/api
	fi
	use source && java-pkg_dosrc "source/ca"
}
