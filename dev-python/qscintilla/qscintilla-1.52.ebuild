# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.52.ebuild,v 1.1 2003/04/29 10:16:18 brain Exp $

inherit eutils

S="${WORKDIR}/${P}-x11-gpl-1.0"
DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
SRC_URI="http://www.river-bank.demon.co.uk/download/QScintilla/${P}-x11-gpl-1.0.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.0.4.1"

src_unpack() {

	unpack ${P}-x11-gpl-1.0.tar.gz
	cd ${S}/qt
	qmake -o Makefile qscintilla.pro
	epatch ${FILESDIR}/${P}-sandbox.patch
	mkdir -p ${D}/${QTDIR}/lib

}

src_compile() {

	cd ${S}/qt
	make all staticlib

}

src_install() {

	cd ${S}/qt
	mkdir -p ${D}/${QTDIR}/{include,translations,lib}
	cp qextscintilla*.h ${D}/$QTDIR/include
	cp qscintilla*.qm ${D}/$QTDIR/translations
	cp libqscintilla.so.* ${D}/$QTDIR/lib
	cp libqscintilla.a* ${D}/$QTDIR/lib

}
