# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.5.1.ebuild,v 1.5 2005/08/18 18:51:05 hansmi Exp $

inherit eutils

SCINTILLA_VER="1.62"
MY_P="${PN}-${SCINTILLA_VER}-gpl-${PV}"
MY_P=${MY_P/_pre/snapshot-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"
#SRC_URI="http://www.river-bank.demon.co.uk/download/snapshots/QScintilla/${MY_P}.tar.gz"
#SRC_URI="http://www.river-bank.demon.co.uk/download/QScintilla/${MY_P}.tar.gz"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="doc"

DEPEND="virtual/libc
	sys-apps/sed
	=x11-libs/qt-3*"

LIBDIR="/usr/$(get_libdir)"

src_unpack() {
	unpack ${A} ; cd ${S}/qt
	sed -i -e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = \${destdir}:" qscintilla.pro
	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> qscintilla.pro

	${QTDIR}/bin/qmake -o Makefile qscintilla.pro
	epatch ${FILESDIR}/${PN}-1.5-sandbox.patch
}

src_compile() {
	cd ${S}/qt
	make destdir=${LIBDIR} all staticlib
}

src_install() {
	dodoc ChangeLog LICENSE NEWS README README.MacOS
	dodir /usr/include ${LIBDIR} /usr/share/qscintilla/translations
	cd ${S}/qt
	cp qextscintilla*.h "${D}/usr/include"
	cp qscintilla*.qm "${D}/usr/share/qscintilla/translations"
	cp libqscintilla.a* "${D}${LIBDIR}"
	cp -d libqscintilla.so.* "${D}${LIBDIR}"
	dodir ${QTDIR}/translations/
	for I in $(ls -1 qscintilla*.qm) ; do
		dosym "/usr/share/qscintilla/translations/${I}" "${QTDIR}/translations/${I}"
	done
	if use doc ; then
		dohtml ${S}/doc/html/*
		insinto /usr/share/doc/${PF}/Scintilla
		doins ${S}/doc/Scintilla/*
	fi
}
