# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qtjambi/qtjambi-4.3.0_p1-r1.ebuild,v 1.7 2007/06/26 01:48:34 mr_bones_ Exp $

inherit eutils java-pkg-2

QTVERSION=4.3.0
PATCHRELEASE=01

DESCRIPTION="QtJambi is a set of Java bindings and utilities for the Qt C++ toolkit."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${QTVERSION}_${PATCHRELEASE}

SRC_URI="ftp://ftp.trolltech.com/pub/qtjambi/source/qtjambi-gpl-src-${MY_PV}.tar.gz"
S=${WORKDIR}/qtjambi-gpl-src-${MY_PV}

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~x86"

IUSE=""

DEPEND="~x11-libs/qt-4.3.0
	>=virtual/jdk-1.5"

RDEPEND="~x11-libs/qt-4.3.0
	>=virtual/jre-1.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/generator.patch
	epatch ${FILESDIR}/qtjambi_base.pri.diff
	epatch ${FILESDIR}/jambipropertysheet.diff
	epatch ${FILESDIR}/jambi.pri.diff

	# If Qt wasn't built with accessibility use flag, then we needto remove some files from
	# the list.
	if ! built_with_use =x11-libs/qt-4* accessibility; then
		epatch ${FILESDIR}/java_files_remove_accessibility.diff
	fi
	if ! built_with_use =x11-libs/qt-4* ssl; then
		epatch ${FILESDIR}/java_files_remove_ssl.diff
	fi

	# These are two private headers from QtDesigner that aren't installed in the normal
	# Qt distribution, but are needed when building QtJambi
	cp ${FILESDIR}/qdesigner_utils_p.h ${S}/qtjambi_designer
	cp ${FILESDIR}/shared_global_p.h ${S}/qtjambi_designer
}

src_compile() {

	# Step 1, build the source generator
	einfo "Building the source generator"
	cd ${S}/generator
	/usr/bin/qmake && make || die "Error building generator"

	# Step 2, run the generator
	einfo "Running the generator.  This may take a few minutes."
	QTDIR=/usr/include/qt4 ./generator

	# Step 3, build the generated sources
	export JAVADIR=$JDK_HOME
	einfo "Building the generated sources."
	cd ${S} && /usr/bin/qmake && make || die "Error building generated sources"

	# Step 4, generate Ui_.java files
	einfo "Running juic"
	cd ${S} && ./bin/juic -cp .

	# Step 5, compiling java files
	einfo "Compiling java files"
	cd ${S} && ejavac @java_files

	# Step 6, build the jar file
	cd ${S} && jar cf qtjambi.jar com
}

src_install() {
	# Install built jar
	java-pkg_dojar qtjambi.jar

	# Install designer plugins
	insinto /usr/$(get_libdir)/qt4/plugins/designer
	insopts -m0755
	doins plugins/designer/*.so

	cp -dpPR ${S}/lib/* ${D}/usr/$(get_libdir)/qt4

	# Install binaries
	dobin bin/*

}
