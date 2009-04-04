# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/glazedlists/glazedlists-1.7.0.ebuild,v 1.3 2009/04/04 19:16:14 maekke Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A toolkit for list transformations"
HOMEPAGE="http://publicobject.com/glazedlists/"
SRC_DOCUMENT_ID_JAVA5="1073/38679"
SRC_DOCUMENT_ID_JAVA4="1073/38683"
SRC_URI="java5? ( https://${PN}.dev.java.net/files/documents/${SRC_DOCUMENT_ID_JAVA5}/${P}-source_java15.zip )
	!java5? ( https://${PN}.dev.java.net/files/documents/${SRC_DOCUMENT_ID_JAVA4}/${P}-source_java14.zip )"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
# TODO: there are extensions, some supported in the java-experimental ebuild
IUSE="java5"

RDEPEND="java5? ( >=virtual/jre-1.5 )
	!java5? ( >=virtual/jre-1.4 )"
DEPEND="java5? ( >=virtual/jdk-1.5 )
	!java5? ( >=virtual/jdk-1.4 )
	app-arch/unzip"

S="${WORKDIR}"

# tests seem to be buggy
RESTRICT="test"

# build file already has correct target version
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable autodownloading of dependencies
	# sort out test targets
	epatch "${FILESDIR}/${P}-build.xml.patch"
}

EANT_DOC_TARGET="docs"

src_install() {
	if use java5; then
		java-pkg_newjar "target/${PN}_java15.jar"
	else
		java-pkg_newjar "target/${PN}_java14.jar"
	fi
	if use doc; then
		dohtml readme.html || die
		java-pkg_dojavadoc "target/docs/api"
	fi
	if use source; then
		# collect source folders for all the used extensions
		local source_folders="source/ca extensions/treetable/source/*"
		java-pkg_dosrc ${source_folders}
	fi
}
