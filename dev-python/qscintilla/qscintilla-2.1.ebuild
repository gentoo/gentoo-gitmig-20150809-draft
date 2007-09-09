# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla/qscintilla-2.1.ebuild,v 1.2 2007/09/09 21:50:53 hawking Exp $

inherit eutils toolchain-funcs python multilib

SCINTILLA_VER="1.73"
MY_P="${PN/qs/QS}-${SCINTILLA_VER}-gpl-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="QScintilla is a port to Qt of Neil Hodgson's Scintilla C++ editor class."
HOMEPAGE="http://www.riverbankcomputing.co.uk/qscintilla/"
SRC_URI="http://www.riverbankcomputing.com/Downloads/QScintilla2/${MY_P}.tar.gz"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="qt4 python doc examples debug"

RDEPEND="qt4? ( =x11-libs/qt-4* )
		!qt4? ( =x11-libs/qt-3* )
		python? ( dev-lang/python
				qt4? ( dev-python/PyQt4 )
				!qt4? ( dev-python/PyQt )
				)"

src_unpack() {
	unpack ${A}

	if use qt4; then
		cd ${S}/Qt4
		sed -i -e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = lib:" qscintilla.pro
		sed -i -e "s:DESTDIR = \$\$\[QT_INSTALL_LIBS\]:DESTDIR = lib:" qscintilla.pro
		echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> qscintilla.pro
		/usr/bin/qmake -o Makefile qscintilla.pro

		cd ${S}/designer-Qt4
		epatch ${FILESDIR}/${P}-qt4.patch

		echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> designer.pro
		/usr/bin/qmake -o Makefile designer.pro
	else
		cd ${S}/Qt3
		sed -i -e "s:DESTDIR = \$(QTDIR)/lib:DESTDIR = lib:" qscintilla.pro
		sed -i -e "s:DESTDIR = \$\$\[QT_INSTALL_LIBS\]:DESTDIR = lib:" qscintilla.pro
		echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> qscintilla.pro
		${QTDIR}/bin/qmake -o Makefile qscintilla.pro

		cd ${S}/designer-Qt3
		epatch ${FILESDIR}/${P}-qt.patch

		sed -i -e "s:DESTDIR = \$(QTDIR)/plugins/designer:DESTDIR = .:" designer.pro
		echo -e "\nQMAKE_CFLAGS_RELEASE=${CFLAGS} -w\nQMAKE_CXXFLAGS_RELEASE=${CXXFLAGS} -w\nQMAKE_LFLAGS_RELEASE=${LDFLAGS}" >> designer.pro
		${QTDIR}/bin/qmake -o Makefile designer.pro
	fi
}

src_compile() {
	if use qt4; then
		cd ${S}/Qt4
	else
		cd ${S}/Qt3
	fi
	make all staticlib CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" || die "make failed"

	if use qt4; then
		cd ${S}/designer-Qt4
		make DESTDIR=${D}/usr/lib/qt4/plugins/designer || die "make failed"
		dodir /usr/lib/qt4/plugins/designer
		if use python; then
			cd ${S}/Python
			python_version
			einfo "Creating bindings for python-${PYVER} ..."
			local myconf="-d \
			/usr/$(get_libdir)/python${PYVER}/site-packages/PyQt4 \
			-v /usr/share/sip \
			-p 4 \
			-n ../Qt4 \
			-o ../Qt4/lib"
			use debug && myconf="${myconf} -u"
			${python} configure.py ${myconf}
			emake || die "emake failed"
		fi
	else
		cd ${S}/designer-Qt3
		make DESTDIR=${D}/${QTDIR}/plugins/designer || die "make failed"
		dodir ${QTDIR}/plugins/designer
		if use python; then
			cd ${S}/Python
			python_version
			einfo "Creating bindings for python-${PYVER} ..."
			local myconf="-d \
			/usr/$(get_libdir)/python${PYVER}/site-packages/ \
			-v /usr/share/sip \
				-p 3 \
			-n ../Qt3 \
			-o ../Qt3/lib"
			use debug && myconf="${myconf} -u"
			${python} configure.py ${myconf}
			emake || die "emake failed"
		fi
	fi
	make
}

src_install() {
	dodoc ChangeLog LICENSE NEWS README*
	dodir /usr/{include,$(get_libdir),share/qscintilla/translations}
	if use qt4; then
		cd ${S}/Qt4
	else
		cd ${S}/Qt3
	fi
	cp -r Qsci "${D}/usr/include"
	#cp qextscintilla*.h "${D}/usr/include"
	cp qscintilla*.qm "${D}/usr/share/qscintilla/translations"
	cp lib/libqscintilla2.a* "${D}/usr/$(get_libdir)"
	cp -d lib/libqscintilla2.so.* "${D}/usr/$(get_libdir)"
	if use qt4; then
		dodir /usr/share/qt4/translations/
		for I in $(ls -1 qscintilla*.qm) ; do
			dosym "/usr/share/qscintilla/translations/${I}" "/usr/share/qt4/translations/${I}"
		done
	else
		dodir ${QTDIR}/translations/
		for I in $(ls -1 qscintilla*.qm) ; do
			dosym "/usr/share/qscintilla/translations/${I}" "${QTDIR}/translations/${I}"
		done
	fi
	if use doc ; then
		dohtml ${S}/doc/html/*
		insinto /usr/share/doc/${PF}/Scintilla
		doins ${S}/doc/Scintilla/*
	fi
	if use qt4; then
		insinto /usr/$(get_libdir)/qt4/plugins/
		insopts  -m0755
		doins ${S}/designer-Qt4/libqscintillaplugin.so
	else
		insinto ${QTDIR}/plugins/designer
		insopts  -m0755
		doins ${S}/designer-Qt3/libqscintillaplugin.so
	fi
	if use python; then
		cd ${S}/Python
		make DESTDIR=${D} install || die "install failed"
	fi
}
