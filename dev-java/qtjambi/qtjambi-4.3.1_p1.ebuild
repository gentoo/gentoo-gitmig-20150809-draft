# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qtjambi/qtjambi-4.3.1_p1.ebuild,v 1.2 2007/08/11 20:24:59 caleb Exp $

inherit eutils java-pkg-2

QTVERSION=4.3.1
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

DEPEND="~x11-libs/qt-${QTVERSION}
	>=virtual/jdk-1.5"

RDEPEND="~x11-libs/qt-${QTVERSION}
	>=virtual/jre-1.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/generator-4.3.1.patch
	epatch ${FILESDIR}/qtjambi_base.pri.diff
	epatch ${FILESDIR}/jambi.pri.diff

	# If Qt wasn't built with accessibility use flag, then we needto remove some files from
	# the list.
	if ! built_with_use =x11-libs/qt-4* accessibility; then
		epatch ${FILESDIR}/java_files_remove_accessibility.diff
	fi
	if ! built_with_use =x11-libs/qt-4* ssl; then
		epatch ${FILESDIR}/java_files_remove_ssl.diff
	fi
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
	mkdir -p ${S}/class
	cd ${S} && ejavac -d class @java_files

	# Step 6, build the jar file
	cd ${S}/class && jar cf ../qtjambi.jar com/trolltech/qt com/trolltech/tools
	# copy built classes for demos and examples
	cd ${S}/class && cp -r com/trolltech/demos com/trolltech/examples com/trolltech/launcher ../com/trolltech
	cd ${S} && jar cf qtjambi-src.jar com

	# generate start scripts
	jcp="/usr/share/qtjambi-4/lib"
	cd ${S} && echo "#!/bin/sh" > bin/jambi-designer
	cd ${S} && echo "LD_LIBRARY_PATH=/usr/lib/qt4 CLASSPATH=${jcp}/qtjambi.jar:${jcp}/qtjambi-src.jar:$CLASSPATH /usr/bin/designer" >> bin/jambi-designer

	cd ${S} && echo "#!/bin/sh" > bin/jambi
	cd ${S} && echo "LD_LIBRARY_PATH=/usr/lib/qt4 java -cp ${jcp}/qtjambi.jar:${jcp}/qtjambi-src.jar com.trolltech.launcher.Launcher" >> bin/jambi
}

src_install() {
	# Install built jar
	java-pkg_dojar qtjambi.jar
	java-pkg_dojar qtjambi-src.jar

	# Install designer plugins
	insinto /usr/$(get_libdir)/qt4/plugins/designer
	insopts -m0755
	doins plugins/designer/*.so

	cp -dpPR ${S}/lib/* ${D}/usr/$(get_libdir)/qt4

	# Install binaries
	dobin bin/*

	einfo "eclipse - Project->Properties->Java Build Path->Libraries:"
	einfo "library:                        /usr/share/qtjambi-4/lib/qtjambi.jar"
	einfo "source (& demos):                /usr/share/qtjambi-4/lib/qtjambi-src.jar"
	einfo "native library location:        /usr/$(get_libdir)/qt4/"
}
