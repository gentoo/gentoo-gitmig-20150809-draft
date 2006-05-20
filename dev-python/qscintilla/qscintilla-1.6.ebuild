# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.6.ebuild,v 1.4 2006/05/20 20:01:33 dertobi123 Exp $

inherit eutils toolchain-funcs

SCINTILLA_VER="1.65"
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
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND="=x11-libs/qt-3*"

src_unpack() {
	unpack ${A}

	cd ${S}/qt
	sed -i -e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = \${destdir}:" qscintilla.pro
	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> qscintilla.pro
	${QTDIR}/bin/qmake -o Makefile qscintilla.pro

	cd ${S}/designer
	sed -i -e "s:LIBS += :LIBS += -L../qt :" designer.pro
	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> designer.pro
	${QTDIR}/bin/qmake -o Makefile designer.pro

	cd ${S}
	epatch ${FILESDIR}/${P}-sandbox.patch
}

src_compile() {
	cd ${S}/qt
	make destdir="${ROOT}/usr/$(get_libdir)" all staticlib CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" || die "make failed"
	cd ${S}/designer
	dodir ${QTDIR}/plugins/designer
	make
}

src_install() {
	dodoc ChangeLog LICENSE NEWS README*
	dodir ${ROOT}/usr/{include,$(get_libdir),share/qscintilla/translations}
	cd ${S}/qt
	cp qextscintilla*.h "${D}/usr/include"
	cp qscintilla*.qm "${D}/usr/share/qscintilla/translations"
	cp libqscintilla.a* "${D}/usr/$(get_libdir)"
	cp -d libqscintilla.so.* "${D}/usr/$(get_libdir)"
	dodir ${QTDIR}/translations/
	for I in $(ls -1 qscintilla*.qm) ; do
		dosym "/usr/share/qscintilla/translations/${I}" "${QTDIR}/translations/${I}"
	done
	if use doc ; then
		dohtml ${S}/doc/html/*
		insinto /usr/share/doc/${PF}/Scintilla
		doins ${S}/doc/Scintilla/*
	fi
	insinto ${QTDIR}/plugins/designer
	insopts  -m0755
	doins ${S}/designer/libqscintillaplugin.so
}
