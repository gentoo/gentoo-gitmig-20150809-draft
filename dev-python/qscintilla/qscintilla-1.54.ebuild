# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.54.ebuild,v 1.13 2005/07/07 12:48:45 caleb Exp $


inherit eutils

S="${WORKDIR}/${P}-x11-gpl-1.2"
DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"
SRC_URI="mirror://gentoo/${P}-x11-gpl-1.2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 amd64"
IUSE=""
DEPEND="virtual/libc
	=x11-libs/qt-3*"

src_unpack() {

	unpack ${P}-x11-gpl-1.2.tar.gz
	cd ${S}/qt
	${QTDIR}/bin/qmake -o Makefile qscintilla.pro
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

