# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.61.ebuild,v 1.4 2004/11/23 19:17:28 carlo Exp $

inherit eutils

MY_P=${P}-gpl-1.4
S=${WORKDIR}/${MY_P}

DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~ia64 ~amd64 ~ppc64"
IUSE="doc"

DEPEND="virtual/libc
	sys-apps/sed
	x11-libs/qt"

src_unpack() {
	unpack ${A}
	cd ${S}/qt
	qmake -o Makefile qscintilla.pro
	sed -i -e "s/CFLAGS   = -pipe -w -O2/CFLAGS   = ${CFLAGS} -w/" Makefile
	sed -i -e "s/CXXFLAGS = -pipe -w -O2/CXXFLAGS = ${CXXFLAGS} -w/" Makefile
	epatch ${FILESDIR}/${P}-sandbox.patch
}

src_compile() {
	cd ${S}/qt
	make all staticlib
}

src_install() {
	dodoc ChangeLog LICENSE NEWS README
	dodir ${QTDIR}/{include,translations,lib}
	cd ${S}/qt
	cp qextscintilla*.h ${D}/$QTDIR/include
	cp qscintilla*.qm ${D}/$QTDIR/translations
	cp libqscintilla.a* ${D}/$QTDIR/lib
	cp -d libqscintilla.so.* ${D}/$QTDIR/lib
	if use doc ; then
		dohtml ${S}/doc/html/*
		insinto /usr/share/doc/${PF}/Scintilla
		doins ${S}/doc/Scintilla/*
	fi
}
