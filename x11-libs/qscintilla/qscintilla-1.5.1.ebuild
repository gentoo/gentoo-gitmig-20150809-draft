# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qscintilla/qscintilla-1.5.1.ebuild,v 1.2 2009/05/05 08:08:39 ssuominen Exp $

inherit eutils toolchain-funcs

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
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND="=x11-libs/qt-3*"
DEPEND="${RDEPEND}
	sys-apps/sed"

LIBDIR="/usr/$(get_libdir)"

src_unpack() {
	unpack ${A} ; cd "${S}"/qt
	sed -i -e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = \${destdir}:" qscintilla.pro
	echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> qscintilla.pro

	${QTDIR}/bin/qmake -o Makefile qscintilla.pro
	epatch "${FILESDIR}"/${PN}-1.5-sandbox.patch
}

src_compile() {
	cd "${S}"/qt
	# It uses g++'s syntax while linking (-Wl,) so it can't use tc-getLD.
	make destdir=${LIBDIR} all staticlib CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" || die "make failed"
}

src_install() {
	dodoc ChangeLog NEWS README
	dodir /usr/include ${LIBDIR} /usr/share/qscintilla/translations
	cd "${S}"/qt
	cp qextscintilla*.h "${D}/usr/include"
	cp qscintilla*.qm "${D}/usr/share/qscintilla/translations"
	cp libqscintilla.a* "${D}${LIBDIR}"
	cp -d libqscintilla.so.* "${D}${LIBDIR}"
	dodir ${QTDIR}/translations/
	for I in $(ls -1 qscintilla*.qm) ; do
		dosym "/usr/share/qscintilla/translations/${I}" "${QTDIR}/translations/${I}"
	done
	if use doc ; then
		dohtml "${S}"/doc/html/*
		insinto /usr/share/doc/${PF}/Scintilla
		doins "${S}"/doc/Scintilla/*
	fi
}
