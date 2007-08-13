# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-1.7.1.ebuild,v 1.7 2007/08/13 20:41:23 dertobi123 Exp $

inherit eutils toolchain-funcs qt3

SCINTILLA_VER="1.71"
MY_P="${PN/qs/QS}-${SCINTILLA_VER}-gpl-${PV}"
MY_P=${MY_P/_pre/snapshot-}

DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"
SRC_URI="http://www.riverbankcomputing.com/Downloads/QScintilla1/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="$(qt_min_version 3.3)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd "${S}/qt"
	sed -i -e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = lib:" qscintilla.pro
	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> qscintilla.pro
	${QTDIR}/bin/qmake -o Makefile qscintilla.pro || die "qmake qscintilla failed"

	cd "${S}"
	epatch "${FILESDIR}/${P}.patch"

	cd "${S}/designer"
	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> designer.pro
	${QTDIR}/bin/qmake -o Makefile designer.pro || die "qmake designer failed"
}

src_compile() {
	cd "${S}/qt"
	emake all staticlib CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" || die "emake failed"
	cd "${S}/designer"
	dodir ${QTDIR}/plugins/designer
	emake || die "emake designer failed"
}

src_install() {
	dodoc ChangeLog NEWS README*
	dodir /usr/{include,$(get_libdir),share/qscintilla/translations}
	cd ${S}/qt
	cp qextscintilla*.h "${D}/usr/include"
	cp qscintilla*.qm "${D}/usr/share/qscintilla/translations"
	cp lib/libqscintilla.a* "${D}/usr/$(get_libdir)"
	cp -R lib/libqscintilla.so.* "${D}/usr/$(get_libdir)"
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
