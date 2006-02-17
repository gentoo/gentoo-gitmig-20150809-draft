# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.54.ebuild,v 1.18 2006/02/17 15:36:55 agriffis Exp $


inherit eutils

S="${WORKDIR}/${P}-x11-gpl-1.2"
DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"
SRC_URI="mirror://gentoo/${P}-x11-gpl-1.2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ~sparc ~x86"
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

