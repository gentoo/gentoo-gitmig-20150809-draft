# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.49.ebuild,v 1.1 2002/12/19 20:32:10 verwilst Exp $

S="${WORKDIR}/${P}-x11-gpl-0.3"
DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
SRC_URI="http://www.river-bank.demon.co.uk/download/QScintilla/${P}-x11-gpl-0.3.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=x11-libs/qt-3.0.4.1"

src_compile() {

	cd ${S}/qt
        qmake -o Makefile qscintilla.pro
        make

}

src_install() {

	cd ${S}/qt
	mkdir -p ${D}/${QTDIR}/{include,translations}	
	cp qextscintilla*.h ${D}/$QTDIR/include
        cp qscintilla*.qm ${D}/$QTDIR/translations
	
}
