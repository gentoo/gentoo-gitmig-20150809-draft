# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/glazedlists/glazedlists-1.5.0.ebuild,v 1.9 2007/08/03 15:36:06 betelgeuse Exp $

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="A toolkit for list transformations"
HOMEPAGE="http://publicobject.com/glazedlists/"
# there's also 1.5 source available, potential java5 useflag
SRC_URI="https://${PN}.dev.java.net/files/documents/1073/26115/${P}-source_java14.zip"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit )
	app-arch/unzip"
S="${WORKDIR}"

# tests need X otherwise fail
RESTRICT="test"

#Patch takes care of this
JAVA_PKG_BSFIX="off"

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

EANT_DOC_TARGET="docs"

src_test() {
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_newjar "${PN}_java14.jar"
	if use doc; then
		dohtml readme.html || die
		java-pkg_dojavadoc docs/api
	fi
	use source && java-pkg_dosrc "source/ca"
}
