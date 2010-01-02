# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qscintilla/qscintilla-2.3.2.ebuild,v 1.11 2010/01/02 21:17:54 yngwin Exp $

EAPI=2
inherit eutils toolchain-funcs multilib

MY_P="${PN/qs/QS}-gpl-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Qt port of Neil Hodgson's Scintilla C++ editor class"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/QScintilla2/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="+python doc examples debug"

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"
PDEPEND="python? ( dev-python/qscintilla-python )"

src_configure() {
	local myqmake myqtdir
	myqmake=/usr/bin/qmake
	myqtdir=Qt4

	cd "${S}/${myqtdir}"
	sed -i \
		-e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = lib:" \
		-e "s:DESTDIR = \$\$\[QT_INSTALL_LIBS\]:DESTDIR = lib:"\
		qscintilla.pro || die "sed in qscintilla.pro failed"

	cat <<- EOF >> qscintilla.pro
	QMAKE_CFLAGS_RELEASE=${CFLAGS} -w
	QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w
	QMAKE_LFLAGS_RELEASE=${LDFLAGS}
	EOF

	${myqmake} -o Makefile qscintilla.pro
	cd "${S}/designer-${myqtdir}"

	epatch "${FILESDIR}/${PN}-2.2-qt4.patch"

		sed -i \
			-e "s:DESTDIR = \$(QTDIR)/plugins/designer:DESTDIR = .:" \
			designer.pro || die "sed in designer.pro failed"

	cat <<- EOF >> designer.pro
	QMAKE_CFLAGS_RELEASE=${CFLAGS} -w
	QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w
	QMAKE_LFLAGS_RELEASE=${LDFLAGS}
	EOF

	${myqmake} -o Makefile designer.pro
}

src_compile() {
	cd "${S}"/Qt4
	make all staticlib CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" || die "make failed"

	cd "${S}"/designer-Qt4
	make DESTDIR="${D}"/usr/lib/qt4/plugins/designer || die "make failed"
	dodir /usr/lib/qt4/plugins/designer
	make
}

src_install() {
	dodoc ChangeLog NEWS README*
	dodir /usr/{include,$(get_libdir),share/qscintilla/translations}
	cd "${S}"/Qt4
	cp -r Qsci "${D}/usr/include"
	#cp qextscintilla*.h "${D}/usr/include"
	cp qscintilla*.qm "${D}/usr/share/qscintilla/translations"
	cp libqscintilla2.a* "${D}/usr/$(get_libdir)"
	cp -d libqscintilla2.so.* "${D}/usr/$(get_libdir)"
	dodir /usr/share/qt4/translations/
	for I in $(ls -1 qscintilla*.qm) ; do
		dosym "/usr/share/qscintilla/translations/${I}" "/usr/share/qt4/translations/${I}"
	done
	if use doc ; then
		dohtml "${S}"/doc/html/*
		insinto /usr/share/doc/${PF}/Scintilla
		doins "${S}"/doc/Scintilla/*
	fi
	insinto /usr/$(get_libdir)/qt4/plugins/designer
	insopts  -m0755
	doins "${S}"/designer-Qt4/libqscintillaplugin.so
}

pkg_postinst() {
	ewarn "Please remerge dev-python/PyQt4 if you have problems with eric4"
	ewarn "or other qscintilla related packages before submitting bug reports."
}
